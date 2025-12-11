<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTasksTable extends Migration
{
    public function up()
    {
        Schema::create('tasks', function (Blueprint $table) {

            //## Basic fields - الحقول الأساسية
            $table->char('id', 36)->primary(); //green UUID primary key - معرف UUID
            $table->string('title'); //green Task title - عنوان المهمة
            $table->text('description')->nullable(); //green Task description - وصف المهمة

            //## Status and priority fields - حقول الحالة والأولوية
            $table->enum('status', ['todo', 'pending', 'in_progress', 'done', 'completed', 'blocked'])->default('todo'); //green Task status - حالة المهمة
            $table->enum('priority', ['low', 'medium', 'high', 'urgent'])->default('medium'); //green Task priority - أولوية المهمة
            $table->smallInteger('progress_percentage')->default(0); //green Progress percentage (0-100) - نسبة الإنجاز

            //## Date fields - حقول التاريخ
            $table->timestamp('start_at')->nullable(); //green Start date - تاريخ البدء
            $table->timestamp('due_at')->nullable(); //green Due date - تاريخ الاستحقاق

            //## Location and attachments - الموقع والمرفقات
            $table->string('location')->nullable(); //green Task location - موقع المهمة
            $table->json('attachments')->nullable(); //green File attachments - المرفقات

            //## Sync fields - حقول المزامنة
            $table->char('uuid', 36)->unique()->nullable(); //green Unique sync identifier - معرف المزامنة الفريد
            $table->enum('sync_status', ['pending', 'synced', 'conflict'])->default('synced'); //green Sync status - حالة المزامنة

            $table->timestamps();
            $table->softDeletes(); //green Soft delete support - دعم الحذف الناعم

            //ref Foreign keys - مفاتيح خارجية
            $table->unsignedBigInteger('assignee_id')->nullable(); //green Assigned user - المستخدم المعين
            $table->char('campaign_id', 36)->nullable(); //green Associated campaign - الحملة المرتبطة
            $table->unsignedBigInteger('client_id')->nullable(); //green Associated client - العميل المرتبط
            $table->char('parent_task_id', 36)->nullable(); //green Parent task for subtasks - المهمة الأم للمهام الفرعية
            $table->unsignedBigInteger('created_by')->nullable(); //green Task creator - منشئ المهمة

            //ref Foreign key relations - علاقات المفتاح الخارجي
            $table->foreign('assignee_id')->references('id')->on('users')->onDelete('set null');
            $table->foreign('campaign_id')->references('id')->on('campaigns')->onDelete('set null');
            $table->foreign('created_by')->references('id')->on('users')->onDelete('set null');
            $table->foreign('parent_task_id')->references('id')->on('tasks')->onDelete('set null');

            //idx Indexes for performance - فهارس لتحسين الأداء
            $table->index(['assignee_id', 'status', 'campaign_id']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('tasks');
    }
}
