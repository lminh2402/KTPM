import api from './api';
import { getAllFees } from './feeService';
import { getAllPayments } from './paymentService';
import { getAllHouseholds } from './householdService';

// Get payment data breakdown by month and fee type
export const getPaymentTrendsByMonth = async (months = 6) => {
  try {
    const payments = await getAllPayments();
    const fees = await getAllFees({ showAll: true });
    
    // Get the date range - from X months ago until now
    const endDate = new Date();
    const startDate = new Date();
    startDate.setMonth(startDate.getMonth() - (months - 1));
    
    // Create array of month names for the period
    const monthLabels = [];
    for (let i = 0; i < months; i++) {
      const date = new Date(startDate);
      date.setMonth(date.getMonth() + i);
      monthLabels.push(date.toLocaleString('default', { month: 'short' }));
    }
    
    // Initialize data with zeros for both fee types
    const monthlyData = monthLabels.map(month => ({
      name: month,
      mandatory: 0,
      voluntary: 0
    }));
    
    // Group fees by type
    const mandatoryFeeIds = fees
      .filter(fee => fee.type === 'MANDATORY')
      .map(fee => fee.id);
    
    // Populate with actual payment data (only verified payments, using amountPaid not requested amount)
    payments.forEach(payment => {
      // Only count verified payments
      if (!payment.verified) return;
      
      const paymentDate = new Date(payment.paymentDate);
      
      // Check if payment is within our date range
      if (paymentDate >= startDate && paymentDate <= endDate) {
        const monthIndex = Math.floor((paymentDate - startDate) / (30 * 24 * 60 * 60 * 1000));
        if (monthIndex >= 0 && monthIndex < months) {
          // Use amountPaid (actual amount paid) instead of amount (requested amount)
          const amountPaid = payment.amountPaid || payment.amount || 0;
          // Check if the fee is mandatory or voluntary
          if (mandatoryFeeIds.includes(payment.feeId)) {
            monthlyData[monthIndex].mandatory += amountPaid;
          } else {
            monthlyData[monthIndex].voluntary += amountPaid;
          }
        }
      }
    });
    
    return monthlyData;
  } catch (error) {
    console.error('Error fetching payment trends by month:', error);
    throw error;
  }
};

// Get payment data by fee
export const getPaymentsByFee = async () => {
  try {
    const payments = await getAllPayments();
    const fees = await getAllFees({ showAll: true });
    
    // Create a map to store total payments by fee (include type for color assignment)
    const feePayments = fees.map(fee => ({
      id: fee.id,
      name: fee.name,
      type: fee.type, // Include fee type (MANDATORY/VOLUNTARY) for color assignment
      value: 0
    }));
    
    // Calculate total for each fee (only verified payments, using amountPaid not requested amount)
    payments.forEach(payment => {
      // Only count verified payments
      if (!payment.verified) return;
      
      const feeIndex = feePayments.findIndex(f => f.id === payment.feeId);
      if (feeIndex !== -1) {
        // Use amountPaid (actual amount paid) instead of amount (requested amount)
        const amountPaid = payment.amountPaid || payment.amount || 0;
        feePayments[feeIndex].value += amountPaid;
      }
    });
    
    // Sort by value and return only those with values > 0
    return feePayments
      .filter(fee => fee.value > 0)
      .sort((a, b) => b.value - a.value);
  } catch (error) {
    console.error('Error fetching payments by fee:', error);
    throw error;
  }
};

// Get collection rate by month
export const getCollectionRateByMonth = async (months = 6) => {
  try {
    const payments = await getAllPayments();
    const households = await getAllHouseholds({ showAll: true });
    const fees = await getAllFees({ showAll: true });
    
    // Get the date range - from X months ago until now
    const endDate = new Date();
    const startDate = new Date();
    startDate.setMonth(startDate.getMonth() - (months - 1));
    
    // Create array of month data
    const monthlyData = [];
    for (let i = 0; i < months; i++) {
      const date = new Date(startDate);
      date.setMonth(date.getMonth() + i);
      
      const monthStart = new Date(date.getFullYear(), date.getMonth(), 1);
      const monthEnd = new Date(date.getFullYear(), date.getMonth() + 1, 0);
      
      // Potential payments for this month (active households × active fees)
      const activeHouseholds = households.filter(h => h.active).length;
      const activeFees = fees.filter(f => f.active && 
        new Date(f.dueDate) >= monthStart && 
        new Date(f.dueDate) <= monthEnd
      ).length;
      
      const potentialPayments = activeHouseholds * activeFees;
      
      // Actual payments for this month
      const actualPayments = payments.filter(payment => {
        const paymentDate = new Date(payment.paymentDate);
        return paymentDate >= monthStart && paymentDate <= monthEnd;
      }).length;
      
      // Calculate collection rate
      const rate = potentialPayments > 0 
        ? Math.round((actualPayments / potentialPayments) * 100)
        : 0;
      
      monthlyData.push({
        name: date.toLocaleString('default', { month: 'short' }),
        rate
      });
    }
    
    return monthlyData;
  } catch (error) {
    console.error('Error fetching collection rate by month:', error);
    throw error;
  }
};

// Get top paying households
export const getTopPayingHouseholds = async (limit = 5) => {
  try {
    const payments = await getAllPayments();
    const households = await getAllHouseholds({ showAll: true });
    
    // Calculate total paid by each household (only verified payments, using amountPaid not requested amount)
    const householdPayments = households.map(household => {
      // Filter for verified payments only
      const householdPayments = payments.filter(p => p.householdId === household.id && p.verified);
      // Use amountPaid (actual amount paid) instead of amount (requested amount)
      const totalPaid = householdPayments.reduce((sum, payment) => {
        const amountPaid = payment.amountPaid || payment.amount || 0;
        return sum + amountPaid;
      }, 0);
      
      // Find the most recent payment date
      let lastPayment = null;
      if (householdPayments.length > 0) {
        lastPayment = householdPayments.reduce((latest, payment) => {
          const paymentDate = new Date(payment.paymentDate);
          return !latest || paymentDate > new Date(latest) ? payment.paymentDate : latest;
        }, null);
      }
      
      return {
        id: household.id,
        ownerName: household.ownerName,
        totalPaid,
        lastPayment
      };
    });
    
    // Sort by total paid and return the top ones
    return householdPayments
      .filter(h => h.totalPaid > 0)
      .sort((a, b) => b.totalPaid - a.totalPaid)
      .slice(0, limit);
  } catch (error) {
    console.error('Error fetching top paying households:', error);
    throw error;
  }
}; 