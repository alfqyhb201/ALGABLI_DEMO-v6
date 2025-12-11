# دليل تشغيل الباك إند (Backend Setup Guide)

تم إعداد هذا المشروع ليعمل باستخدام قاعدة بيانات SQLite لسهولة التطوير والتشغيل.

## المتطلبات المسبقة (Prerequisites)

تأكد من تثبيت الأدوات التالية على جهازك:
*   PHP >= 8.2
*   Composer

## خطوات التثبيت والتشغيل السريع

### 1. إعداد البيئة
قم بنسخ ملف البيئة وتثبيت المكتبات:

```bash
cd backend
cp .env.example .env
# تأكد من أن DB_CONNECTION=sqlite في ملف .env
composer install
```

### 2. إعداد قاعدة البيانات
قم بإنشاء ملف قاعدة البيانات، توليد المفتاح، وتشغيل التهجير والبيانات الأولية:

```bash
# إنشاء ملف قاعدة البيانات (Linux/Mac)
touch database/database.sqlite

# إنشاء المفتاح
php artisan key:generate

# تشغيل التهجير والبيانات الأولية (Seeders)
php artisan migrate:fresh --seed
```

### 3. تشغيل الخادم
لتشغيل الخادم المحلي:

```bash
php artisan serve
```

سيعمل الخادم عادةً على الرابط: `http://127.0.0.1:8000`

## ملاحظات هامة

*   **API URL:** بالنسبة لتطبيق Flutter، إذا كنت تستخدم Android Emulator، فإن الرابط للوصول للـ localhost هو `http://10.0.2.2:8000/api`.
*   **المستخدمين الافتراضيين (Seeders):**
    *   **Admin:** `admin@algabli.com` / `123`
    *   **Manager:** `manager@algabli.com` / `123`
    *   **Field Agent:** `mohamed@algabli.com` / `123`

## استكشاف الأخطاء وإصلاحها

*   **خطأ `UUID()`:** تم تعديل ملفات الـ migration والموديل لاستخدام `Str::uuid()` في PHP بدلاً من الاعتماد على دالة `UUID()` في قاعدة البيانات، وذلك لدعم SQLite.
*   **مشاكل الصلاحيات:** تأكد من أن المجلد `storage` و `database/database.sqlite` لديهم صلاحيات الكتابة.
