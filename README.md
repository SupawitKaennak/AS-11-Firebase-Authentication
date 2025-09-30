<img width="254" height="539" alt="image" src="https://github.com/user-attachments/assets/84529623-c047-4a5b-8fb0-3325d9506d66" />
<img width="254" height="539" alt="image" src="https://github.com/user-attachments/assets/35ed5080-c778-4196-a5df-2a75272b5298" />
<img width="254" height="539" alt="image" src="https://github.com/user-attachments/assets/38efc546-d052-41f4-b4bd-e40525a95536" />
<img width="254" height="539" alt="image" src="https://github.com/user-attachments/assets/4f2b3b6e-a625-4154-b77a-f87434de1117" />
<img width="254" height="539" alt="image" src="https://github.com/user-attachments/assets/da42eb9e-7c75-4b56-9b5d-3db57869de53" />
<img width="254" height="539" alt="image" src="https://github.com/user-attachments/assets/d993d0cd-44e7-4287-a206-5f4d10df4e37" />
<img width="1564" height="850" alt="image" src="https://github.com/user-attachments/assets/3ce37964-78e6-4d57-b351-f91cd2cf7d1c" />


# แอปพลิเคชันลงทะเบียนและยืนยันตัวตน (Flutter Firebase & SQFlite)

แอปพลิเคชันตัวอย่างสำหรับ Flutter ที่สาธิตการทำงานร่วมกันระหว่าง **Firebase Authentication** สำหรับการจัดการผู้ใช้ (สมัครสมาชิก, เข้าสู่ระบบ) และ **SQFlite** สำหรับการจัดเก็บข้อมูลกิจกรรมที่ลงทะเบียนไว้บนอุปกรณ์ (Local Database)

## ✨ ฟีเจอร์หลัก

- **ระบบยืนยันตัวตน (Firebase Authentication):**
  - สมัครสมาชิกด้วยอีเมลและรหัสผ่าน
  - เข้าสู่ระบบ (Login) และออกจากระบบ (Logout)
  - การจัดการสถานะการล็อกอินแบบ Real-time ด้วย Provider และ StreamBuilder
  - หน้าสำหรับรีเซ็ตรหัสผ่าน
- **ระบบจัดการข้อมูล (SQFlite):**
  - หน้าฟอร์มสำหรับลงทะเบียนข้อมูลนักศึกษาเข้าร่วมกิจกรรม
  - บันทึกข้อมูลลงในฐานข้อมูล SQLite บนเครื่อง
  - หน้าสำหรับแสดงรายการข้อมูลที่ลงทะเบียนไว้ทั้งหมด
  - รองรับการดึงข้อมูลเพื่อแสดงผล (Read) และการเพิ่มข้อมูล (Create)
- **การจัดการสถานะ (State Management):**
  - ใช้ `provider` และ `ChangeNotifierProvider` ในการจัดการสถานะการล็อกอิน (loading, user data, errors)
- **UI/UX:**
  - ดีไซน์หน้าจอที่สวยงามและใช้งานง่าย
  - มีการแสดงสถานะ Loading ขณะประมวลผล
  - การแจ้งเตือนผู้ใช้ด้วย SnackBar

---

## 🚀 การติดตั้งและเริ่มต้นใช้งาน (Getting Started)

ทำตามขั้นตอนต่อไปนี้เพื่อตั้งค่าโปรเจกต์และรันแอปพลิเคชันบนเครื่องของคุณ

### 1. ข้อกำหนดเบื้องต้น (Prerequisites)

- ติดตั้ง Flutter SDK เรียบร้อยแล้ว
- ติดตั้ง Visual Studio Code หรือ Android Studio
- มีบัญชี Google เพื่อใช้งาน Firebase

### 2. ตั้งค่า Firebase

1.  **สร้างโปรเจกต์ Firebase:**
    - ไปที่ Firebase Console
    - คลิก "Add project" และทำตามขั้นตอนเพื่อสร้างโปรเจกต์ใหม่

2.  **เปิดใช้งาน Authentication:**
    - ในโปรเจกต์ของคุณ ไปที่เมนู `Build > Authentication`
    - เลือกแท็บ `Sign-in method`
    - คลิกเปิดใช้งาน `Email/Password`

3.  **ติดตั้ง Firebase CLI และเชื่อมต่อโปรเจกต์:**
    - เปิด Terminal แล้วติดตั้ง Firebase CLI:
      ```bash
      npm install -g firebase-tools
      ```
    - ล็อกอินเข้าสู่ระบบ Firebase:
      ```bash
      firebase login
      ```
    - ในโปรเจกต์ Flutter ของคุณ ให้รันคำสั่ง `flutterfire configure` เพื่อเชื่อมต่อแอปกับ Firebase ที่สร้างไว้ (เลือกโปรเจกต์ที่ถูกต้องเมื่อมีคำถาม):
      ```bash
      flutterfire configure
      ```
    - คำสั่งนี้จะสร้างไฟล์ `lib/firebase_options.dart` และแก้ไขไฟล์ที่จำเป็นใน Android/iOS ให้โดยอัตโนมัติ

4.  **(สำหรับ Android) เพิ่ม SHA-1 Fingerprint:**
    - เพื่อให้ Firebase Authentication ทำงานได้อย่างสมบูรณ์ (โดยเฉพาะฟีเจอร์อื่นๆ ในอนาคต) ควรเพิ่ม SHA-1 key ลงในโปรเจกต์ Firebase
    - รันคำสั่งนี้ใน Terminal ที่ root ของโปรเจกต์ Flutter เพื่อดูค่า SHA-1:
      ```bash
      cd android && ./gradlew signingReport
      ```
    - คัดลอกค่า **SHA-1** ของ `debugAndroidTest`
    - ไปที่ Firebase Console > Project Settings (ไอคอนเฟือง ⚙️) > เลื่อนลงมาที่ "Your apps"
    - เลือกแอป Android ของคุณ แล้วคลิก **"Add fingerprint"** จากนั้นวางค่า SHA-1 ที่คัดลอกมา
    - ดาวน์โหลดไฟล์ `google-services.json` ตัวใหม่มาทับไฟล์เดิมที่ `android/app/google-services.json`

### 3. รันแอปพลิเคชัน

1.  **Clone a Repository (ถ้ามี):**
    ```bash
    git clone <your-repository-url>
    cd firebase_auth_provider_app
    ```

2.  **ติดตั้ง Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **รันแอป:**
    - เชื่อมต่อโทรศัพท์หรือเปิด Emulator
    - รันคำสั่ง:
      ```bash
      flutter run
      ```

---

## 📖 วิธีการใช้งาน

1.  **สมัครสมาชิก:**
    - ที่หน้าแรก (AuthScreen) คลิก "ยังไม่มีบัญชี? สมัครสมาชิก"
    - กรอกอีเมลและรหัสผ่าน (อย่างน้อย 6 ตัวอักษร) แล้วกด "สมัครสมาชิก"
2.  **เข้าสู่ระบบ:**
    - กรอกอีเมลและรหัสผ่านที่สมัครไว้ แล้วกด "เข้าสู่ระบบ"
    - เมื่อสำเร็จ จะเข้าสู่หน้าแรก (HomeScreen)
3.  **ลงทะเบียนกิจกรรม:**
    - ที่หน้าแรก กดปุ่ม "ลงทะเบียนกิจกรรม"
    - กรอกข้อมูลนักศึกษาและชื่อกิจกรรมให้ครบถ้วน แล้วกด "ลงทะเบียน"
4.  **ดูข้อมูลที่ลงทะเบียน:**
    - กลับมาที่หน้าแรก แล้วกดปุ่ม "ดูข้อมูลการลงทะเบียน"
    - แอปจะแสดงรายการข้อมูลทั้งหมดที่เคยบันทึกไว้ในฐานข้อมูล SQFlite
5.  **ออกจากระบบ:**
    - ที่หน้าแรก กดไอคอน Logout (รูปประตู) ที่มุมขวาบนของ AppBar
