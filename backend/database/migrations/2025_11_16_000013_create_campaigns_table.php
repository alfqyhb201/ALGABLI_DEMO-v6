<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCampaignsTable extends Migration
{
    public function up()
    {
        Schema::create('campaigns', function (Blueprint $table) {

            //## Basic fields - الحقول الأساسية
            $table->char('id', 36)->primary(); //green UUID primary key - معرف UUID
            $table->string('code')->nullable()->unique(); //green Unique campaign code - رمز الحملة الفريد
            $table->string('title'); //green Campaign title - عنوان الحملة
            $table->string('campaign_type')->nullable(); //green Campaign type - نوع الحملة ex: 'marketing', 'sales', 'awareness'
            $table->text('objective')->nullable(); //green Campaign objective - هدف الحملة

            //## Status and dates - الحالة والتواريخ
            $table->enum('status', ['draft', 'active', 'paused', 'completed', 'cancelled'])->default('draft'); //green Campaign status - حالة الحملة
            $table->date('start_date')->nullable(); //green Start date - تاريخ البدء
            $table->date('end_date')->nullable(); //green End date - تاريخ الانتهاء

            //## Financial and results - المالية والنتائج
            $table->decimal('budget', 14, 2)->nullable(); //green Campaign budget - ميزانية الحملة
            $table->json('result_summary')->nullable(); //green Campaign results summary - ملخص نتائج الحملة

            $table->timestamps();
            $table->softDeletes(); //green Soft delete support - دعم الحذف الناعم

            //ref Foreign keys - مفاتيح خارجية
            $table->unsignedBigInteger('owner_id')->nullable(); //green Campaign owner/manager - مالك/مدير الحملة

            //ref Foreign key relations - علاقات المفتاح الخارجي
            $table->foreign('owner_id')->references('id')->on('users')->onDelete('set null');

            //idx Indexes for performance - فهارس لتحسين الأداء
            $table->index(['status', 'start_date']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('campaigns');
    }
}
