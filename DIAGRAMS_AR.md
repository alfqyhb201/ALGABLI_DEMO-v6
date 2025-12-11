# 📊 مخططات نظام الجبلي الميداني

يحتوي هذا الملف على المخططات الشاملة للنظام (Frontend & Backend) باستخدام لغة Mermaid JS، والتي توضح الهيكلية، قواعد البيانات، سير العمل، والخطة الزمنية.

## 1. المخطط الهيكلي للنظام (System Architecture)

يوضح هذا المخطط المكونات الرئيسية للنظام والعلاقات بينها: تطبيق الهاتف للمسوقين، ولوحة التحكم للإدارة، والخوادم وقواعد البيانات.

```mermaid
graph TD
    %% المستخدمون
    UserMobile[👤 المسوق الميداني] -->|يستخدم| MobileApp[📱 تطبيق Flutter]
    UserManager[👤 المدير/المشرف] -->|يستخدم| AdminPanel[💻 لوحة تحكم Filament]

    %% تطبيق الموبايل
    subgraph "Mobile Client (Frontend)"
        direction TB
        MobileApp -->|يقرأ/يكتب| LocalDB[(🗄️ Drift / SQLite)]
        MobileApp -->|يخزن ملفات| LocalStorage[📂 Secure Storage]
        MobileApp -->|يدير| SyncWorker[🔄 Sync Service / Queue]
    end

    %% السيرفر
    subgraph "Backend Server (Laravel)"
        direction TB
        AdminPanel -->|HTTPS| Laravel[⚙️ Laravel Core]
        SyncWorker -->|API / JSON| API[🔌 API Routes]
        API -->|مصادقة| Sanctum[🔐 Laravel Sanctum]
        API -->|يعالج| Controllers[🎮 Controllers]
        Controllers -->|يخزن| ServerDB[(🗄️ MySQL Database)]
        Laravel -->|يدير| Shield[🛡️ Filament Shield (Roles)]
    end

    %% التنسيق
    style MobileApp fill:#e3f2fd,stroke:#1565c0,stroke-width:2px
    style AdminPanel fill:#fff3e0,stroke:#e65100,stroke-width:2px
    style ServerDB fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    style LocalDB fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px
    style API fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
```

---

## 2. مخطط قاعدة البيانات الخلفية (Backend ER Diagram)

يوضح العلاقات بين الجداول الرئيسية في قاعدة بيانات السيرفر (MySQL).

```mermaid
erDiagram
    %% الجداول الرئيسية
    USERS ||--o{ TASKS : "ينشئ/ينفذ"
    USERS ||--o{ CAMPAIGNS : "يدير"
    AGENTS ||--o{ CLIENTS : "يملك"
    BRANCHES ||--o{ CLIENTS : "يحتوي"
    
    CLIENTS ||--o{ TASKS : "له"
    CAMPAIGNS ||--o{ TASKS : "تتضمن"
    
    EVALUATION_TEMPLATES ||--o{ EVALUATION_CRITERIA : "يحتوي"
    USERS ||--o{ EVALUATIONS : "يُقيّم"
    CLIENTS ||--o{ EVALUATIONS : "يُقيّم"

    %% تفاصيل الجداول
    USERS {
        bigint id PK
        string name
        string email
        string role
        boolean is_active
    }

    CLIENTS {
        uuid id PK
        string name
        string phone
        string category
        foreign_key agent_id
        foreign_key branch_id
        string gps_location
        string loyalty_level
    }

    TASKS {
        uuid id PK
        string title
        string status
        string priority
        datetime due_at
        foreign_key client_id
        foreign_key campaign_id
        foreign_key assignee_id
    }

    CAMPAIGNS {
        uuid id PK
        string title
        string code
        date start_date
        date end_date
        float budget
    }

    AGENTS {
        id id PK
        string name
        string region
    }

    EVALUATIONS {
        id id PK
        int total_score
        text notes
        morph evaluable_type
    }
```

---

## 3. مخطط قاعدة البيانات المحلية (Frontend ER Diagram)

يوضح جداول قاعدة البيانات المحلية (Drift/SQLite) وكيفية تخزين البيانات أوفلاين.

```mermaid
erDiagram
    %% العلاقات المحلية
    Local_Clients ||--o{ Local_Tasks : "مرتبط بـ"
    Local_Campaigns ||--o{ Local_Tasks : "يحتوي"
    Local_Tasks ||--o{ Field_Reports : "يولد"
    
    %% الجداول
    Local_Clients {
        int id PK
        string remote_id "UUID من السيرفر"
        string name
        json phone_numbers
        string sync_status "pending/synced"
        boolean is_draft
    }

    Local_Tasks {
        string id PK "UUID"
        string title
        string description
        string status
        string priority
        datetime due_at
        string sync_status
    }

    Local_Campaigns {
        string id PK
        string title
        string objective
        date start_date
        date end_date
    }

    Field_Reports {
        string id PK
        string task_id FK
        text notes
        json photos_paths
        string gps_coords
        string sync_status
    }

    Sync_Queue {
        int id PK
        string entity "اسم الجدول"
        string operation "create/update"
        json payload "البيانات"
        string status "retry/failed"
        int retry_count
    }
```

---

## 4. مخطط رحلة المستخدم (User Flow)

يوضح الخطوات التي يقوم بها المسوق الميداني منذ فتح التطبيق وحتى إتمام المهام.

```mermaid
flowchart TD
    Start((🚀 البداية)) --> Splash[شاشة البداية]
    Splash --> AuthCheck{هل مسجل دخول؟}
    
    %% مسار تسجيل الدخول
    AuthCheck -- لا --> Login[شاشة تسجيل الدخول]
    Login -->|إدخال البيانات| APIAuth{تحقق API}
    APIAuth -- خطأ --> LoginError[رسالة خطأ]
    LoginError --> Login
    APIAuth -- نجاح --> InitialSync[مزامنة أولية للبيانات]
    InitialSync --> Home[🏠 الشاشة الرئيسية]
    
    %% مسار العمل الرئيسي
    AuthCheck -- نعم --> Home
    
    Home --> SelectAction{اختر نشاط}
    
    %% سيناريو زيارة عميل
    SelectAction -->|👥 العملاء| ClientsList[قائمة العملاء]
    ClientsList -->|بحث/فلترة| SelectClient[اختيار عميل]
    SelectClient --> ClientProfile[ملف العميل]
    ClientProfile --> CheckIn[📍 تسجيل وصول]
    CheckIn --> ClientActions{إجراءات الزيارة}
    
    ClientActions -->|📝 تقرير| CreateReport[إضافة تقرير ميداني]
    ClientActions -->|📋 مهمة| CreateTask[إضافة مهمة جديدة]
    ClientActions -->|📸 صور| TakePhoto[التقاط صور]
    
    CreateReport --> SaveLocal[حفظ محلي SQLite]
    CreateTask --> SaveLocal
    TakePhoto --> SaveLocal
    
    SaveLocal --> CheckOut[تسجيل خروج]
    CheckOut --> AddToQueue[إضافة لطابور المزامنة]
    AddToQueue --> Home
    
    %% سيناريو المزامنة
    Home -->|🔄 مزامنة| SyncButton[ضغط زر المزامنة]
    SyncButton --> UploadPending[رفع البيانات المعلقة]
    UploadPending --> DownloadUpdates[جلب التحديثات الجديدة]
    DownloadUpdates --> UpdateUI[تحديث الواجهة]
```

---

## 5. الخطة الزمنية للمشروع (Project Roadmap)

مخطط جانت (Gantt Chart) يوضح الجدول الزمني المقترح (8 أسابيع) لإكمال المشروع بناءً على التحليل الحالي.

```mermaid
gantt
    title 🗓️ خطة إكمال مشروع الجبلي الميداني
    dateFormat  YYYY-MM-DD
    axisFormat  %W أسبوع
    
    section 1. Backend API
    إكمال الـ Controllers      :done,    des1, 2025-12-07, 2025-12-10
    قواعد التحقق Validation    :active,  des2, 2025-12-10, 2025-12-12
    التوثيق API Docs           :         des3, 2025-12-12, 2025-12-14

    section 2. المزامنة Sync
    تفعيل Sync Queue           :         sync1, 2025-12-14, 2025-12-17
    معالجة التعارضات Conflicts :         sync2, after sync1, 3d
    اختبار المزامنة            :         sync3, after sync2, 2d

    section 3. ربط الواجهات
    ربط شاشات العملاء          :         ui1, 2025-12-21, 4d
    ربط شاشات المهام           :         ui2, after ui1, 3d
    ربط الحملات والتقارير      :         ui3, after ui2, 3d

    section 4. الميزات المتقدمة
    تفعيل الخرائط GPS          :         feat1, 2026-01-04, 4d
    الكاميرا وإدارة الصور      :         feat2, after feat1, 3d
    الإشعارات Push Notif       :         feat3, after feat2, 3d

    section 5. الاختبار والنشر
    Unit & Integration Tests   :         test1, 2026-01-18, 5d
    اختبار الأداء والواجهة     :         test2, after test1, 2d
    النشر Production           :         deploy, 2026-01-25, 5d
```
