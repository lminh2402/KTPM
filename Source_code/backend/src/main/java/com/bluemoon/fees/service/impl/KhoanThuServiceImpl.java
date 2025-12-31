package com.bluemoon.fees.service.impl;

import com.bluemoon.fees.entity.HoKhau;
import com.bluemoon.fees.entity.KhoanThu;
import com.bluemoon.fees.entity.NopPhi;
import com.bluemoon.fees.exception.ResourceNotFoundException;
import com.bluemoon.fees.repository.KhoanThuRepository;
import com.bluemoon.fees.repository.NopPhiRepository;
import com.bluemoon.fees.service.HoKhauService;
import com.bluemoon.fees.service.KhoanThuService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class KhoanThuServiceImpl implements KhoanThuService {

    private final KhoanThuRepository khoanThuRepository;
    private final HoKhauService hoKhauService;
    private final NopPhiRepository nopPhiRepository;

    @Override
    public KhoanThu save(KhoanThu entity) {
        return khoanThuRepository.save(entity);
    }

    @Override
    public List<KhoanThu> saveAll(List<KhoanThu> entities) {
        return khoanThuRepository.saveAll(entities);
    }

    @Override
    public Optional<KhoanThu> findById(Long id) {
        return khoanThuRepository.findById(id);
    }

    @Override
    public List<KhoanThu> findAll() {
        return khoanThuRepository.findAll();
    }

    @Override
    public void deleteById(Long id) {
        khoanThuRepository.deleteById(id);
    }

    @Override
    public void delete(KhoanThu entity) {
        khoanThuRepository.delete(entity);
    }

    @Override
    public boolean existsById(Long id) {
        return khoanThuRepository.existsById(id);
    }

    @Override
    public List<KhoanThu> findAllActive() {
        return khoanThuRepository.findByHoatDongTrue();
    }

    @Override
    public KhoanThu findActiveById(Long id) {
        return khoanThuRepository.findByIdAndHoatDongTrue(id)
                .orElseThrow(() -> new ResourceNotFoundException("Fee not found with ID: " + id));
    }

    @Override
    public List<KhoanThu> findByBatBuoc(Boolean batBuoc) {
        return khoanThuRepository.findByBatBuocAndHoatDongTrue(batBuoc);
    }

    @Override
    public List<KhoanThu> findByThoiHanRange(LocalDate startDate, LocalDate endDate) {
        return khoanThuRepository.findByThoiHanBetweenAndHoatDongTrue(startDate, endDate);
    }

    @Override
    public List<KhoanThu> findOverdueKhoanThu() {
        return khoanThuRepository.findByThoiHanBeforeAndHoatDongTrue(LocalDate.now());
    }

    @Override
    public KhoanThu createKhoanThu(KhoanThu khoanThu) {
        // Set default values if needed
        if (khoanThu.getNgayTao() == null) {
            khoanThu.setNgayTao(LocalDate.now());
        }
        
        khoanThu.setHoatDong(true);
        
        // Save the fee first
        KhoanThu savedKhoanThu = khoanThuRepository.save(khoanThu);
        
        // If this is a mandatory fee, automatically create payment records for all active households
        if (savedKhoanThu.getBatBuoc() != null && savedKhoanThu.getBatBuoc()) {
            log.info("Mandatory fee created (ID: {}), creating payment records for all active households", savedKhoanThu.getId());
            createPaymentRecordsForAllHouseholds(savedKhoanThu);
        }
        
        return savedKhoanThu;
    }
    
    /**
     * Creates payment records (NopPhi) for all active households for a given mandatory fee
     */
    private void createPaymentRecordsForAllHouseholds(KhoanThu khoanThu) {
        try {
            // Get all active households
            List<HoKhau> activeHouseholds = hoKhauService.findAllActive();
            log.info("Found {} active households, creating payment records for mandatory fee: {}", 
                    activeHouseholds.size(), khoanThu.getTenKhoanThu());
            
            int createdCount = 0;
            for (HoKhau hoKhau : activeHouseholds) {
                // Check if payment already exists for this household and fee
                if (nopPhiRepository.findByHoKhauIdAndKhoanThuId(hoKhau.getId(), khoanThu.getId()).isPresent()) {
                    // Payment already exists, skip
                    log.debug("Payment already exists for household {} and fee {}, skipping", 
                            hoKhau.getId(), khoanThu.getId());
                    continue;
                }
                
                // Create new payment record
                NopPhi nopPhi = new NopPhi();
                nopPhi.setHoKhau(hoKhau);
                nopPhi.setKhoanThu(khoanThu);
                nopPhi.setTongTien(khoanThu.getSoTien()); // Requested amount
                nopPhi.setSoTien(0.0); // Amount paid (initially 0, will be updated when payment is made)
                // Set payment date to fee's due date (will be updated to actual payment date when paid)
                nopPhi.setNgayNop(khoanThu.getThoiHan() != null ? khoanThu.getThoiHan() : LocalDate.now());
                nopPhi.setDaXacNhan(false); // Not verified yet - accountant will verify when payment is made
                nopPhi.setGhiChu("Tự động tạo cho khoản thu bắt buộc"); // Auto-generated note
                
                // Save directly using repository to avoid service layer complexity
                nopPhiRepository.save(nopPhi);
                createdCount++;
            }
            
            log.info("Successfully created {} payment records for mandatory fee: {}", 
                    createdCount, khoanThu.getTenKhoanThu());
        } catch (Exception e) {
            log.error("Error creating payment records for mandatory fee {}: {}", 
                    khoanThu.getId(), e.getMessage(), e);
            // Don't throw exception - fee creation should succeed even if payment creation fails
            // The payment records can be created manually later
        }
    }

    @Override
    public KhoanThu updateKhoanThu(Long id, KhoanThu khoanThu) {
        KhoanThu existingKhoanThu = findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Fee not found with ID: " + id));
        
        // Update fields
        existingKhoanThu.setTenKhoanThu(khoanThu.getTenKhoanThu());
        existingKhoanThu.setBatBuoc(khoanThu.getBatBuoc());
        existingKhoanThu.setSoTien(khoanThu.getSoTien());
        existingKhoanThu.setThoiHan(khoanThu.getThoiHan());
        existingKhoanThu.setGhiChu(khoanThu.getGhiChu());
        existingKhoanThu.setHoatDong(khoanThu.isHoatDong());
        
        return khoanThuRepository.save(existingKhoanThu);
    }

    @Override
    public void deactivateKhoanThu(Long id) {
        KhoanThu khoanThu = findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Fee not found with ID: " + id));
        khoanThu.setHoatDong(false);
        khoanThuRepository.save(khoanThu);
    }

    @Override
    public void activateKhoanThu(Long id) {
        KhoanThu khoanThu = findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Fee not found with ID: " + id));
        khoanThu.setHoatDong(true);
        khoanThuRepository.save(khoanThu);
    }
}