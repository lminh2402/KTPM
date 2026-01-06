Hướng dẫn cài đặt
-	Để sử dụng phần mềm, cần chuẩn bị môi trường chạy Java Spring Boot và ReactJS.
-	Cài đặt một số công cụ và thư viện cần thiết như:
o	JDK (Java Development Kit) phiên bản 17 trở lên. (Cài đặt trong link sau)
o	Maven (Download Apache Maven – Maven)
o	MySQL Server (MySQL :: Download MySQL Installer)
o	NodeJs Ver 20.14.0 (Node.js — Node v20.14.0 (LTS))
-	Cài đặt IDE hỗ trợ phát triển Java và ReactJs (IntelliJ IDEA, Eclipse, hoặc Visual Studio Code).
Hướng dẫn được tạo dành cho HĐH Windows 10/11 64bit
0.	Tải và giải nén mã nguồn
-	Tải và giải nén mã nguồn từ link: Source code và Database
1.	Cài đặt Backend 
-	Truy cập vào folder Backend trong thư mục mã nguồn
1.1.	Cài đặt Java JDK và thiết lập biến môi trường:
-	Tải JDK 17 từ trang chủ: Download the Microsoft Build of OpenJDK | Microsoft Learn
-	Chạy file cài đặt và làm theo hướng dẫn
-	Thiết lập biến môi trường:
o	Thêm biến JAVA_HOME với đường dẫn cài đặt JDK
o	Thêm %JAVA_HOME%\bin vào biến PATH
o	Kiểm tra: Mở Command Prompt và chạy java -version
1.2.	Cài đặt MySQL Server:
-	Tải MySQL Server từ MySQL :: Download MySQL Community Server 
-	Sau khi cài đặt, sử dụng MySQL Workbench để tạo cơ sở dữ liệu với file .sql có sẵn trong thư mục dự án.
1.3.	Cài đặt Maven:
-	Tải và cài đặt Maven từ Download Apache Maven – Maven
-	Giải nén vào thư mục (ví dụ: C:\apache-maven-3.9.0)
-	Thiết lập biến môi trường:
o	Thêm biến MAVEN_HOME với đường dẫn Maven
o	Thêm %MAVEN_HOME%\bin vào biến PATH
o	Kiểm tra: mvn -version
1.4.	Chạy Backend 
-	Sử dụng lệnh sau để khởi chạy Backend: mvn spring-boot:run 
-	Backend sẽ khởi chạy trên cổng mặc định (thường là http://localhost:8080).
1.5.	Cấu hình cơ sở dữ liệu trong ứng dụng:
-	Mở file application.properties trong dự án.
-	Chỉnh sửa các thông tin kết nối: 
spring.datasource.url=jdbc:mysql://localhost:3306/ten_database spring.datasource.username=ten_user 
spring.datasource.password=mat_khau
2.	Cài đặt Frontend
- Truy cập vào folder Frontend trong thư mục mã nguồn
2.1. Cài đặt NodeJS
-	Tải và cài đặt NodeJS từ Node.js — Node v20.14.0 (LTS)
2.2. Cài đặt thư viện Frontend
-	Vào thư mục Frontend
-	Sử dụng lệnh ‘npm install –legacy-peer-deps ‘
2.3. Chạy Frontend
-	Sử dụng lệnh sau để khởi chạy Frontend: npm run dev 
-	Ứng dụng sẽ khởi chạy trên cổng mặc định (thường là http://localhost:3030/).
3.	Tài khoản chạy thử
-	ADMIN: admin / admin123

