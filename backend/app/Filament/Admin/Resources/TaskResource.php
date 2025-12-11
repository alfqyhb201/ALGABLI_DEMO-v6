<?php

namespace App\Filament\Admin\Resources;

use App\Filament\Admin\Resources\TaskResource\Pages;
use App\Filament\Admin\Resources\TaskResource\RelationManagers;
use App\Models\Task;
use Filament\Forms;
use Filament\Forms\Components\Grid;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Forms\Components\RichEditor;

class TaskResource extends Resource
{
    protected static ?string $model = Task::class;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-list';

    protected static ?string $navigationLabel = 'المهام';

    protected static ?string $modelLabel = 'مهمة';

    protected static ?string $pluralModelLabel = 'المهام';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('تفاصيل المهمة')
                    ->schema([
                        Forms\Components\TextInput::make('title')
                            ->label('العنوان')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\Select::make('priority')
                            ->label('الأولوية')
                            ->options([
                                'low' => 'منخفضة',
                                'medium' => 'متوسطة',
                                'high' => 'عالية',
                                'urgent' => 'عاجلة',
                            ])
                            ->default('medium')
                            ->required(),
                        Forms\Components\Select::make('status')
                            ->label('الحالة')
                            ->options([
                                'todo' => 'للقيام',
                                'pending' => 'قيد الانتظار',
                                'in_progress' => 'قيد التنفيذ',
                                'done' => 'منجزة',
                                'completed' => 'مكتملة',
                                'blocked' => 'معلقة',
                            ])
                            ->default('todo')
                            ->required(),
                        Forms\Components\TextInput::make('progress_percentage')
                            ->label('نسبة الإنجاز')
                            ->numeric()
                            ->default(0)
                            ->suffix('%')
                            ->maxValue(100)
                            ->minValue(0),
                    ])->columns(2),

                Forms\Components\Section::make('التعيين والارتباط')
                    ->schema([
                        Forms\Components\Select::make('assignees')
                            ->label('المكلفين')
                            ->relationship('assignees', 'name')
                            ->multiple()
                            ->searchable()
                            ->preload(),
                        Forms\Components\Select::make('campaign_id')
                            ->label('الحملة')
                            ->relationship('campaign', 'title')
                            ->searchable()
                            ->preload(),
                        Forms\Components\Select::make('client_id')
                            ->label('العميل')
                            ->relationship('client', 'name')
                            ->searchable()
                            ->preload(),
                        Forms\Components\Select::make('parent_task_id')
                            ->label('المهمة الرئيسية')
                            ->relationship('parentTask', 'title')
                            ->searchable()
                            ->preload(),
                    ])->columns(2),

                Forms\Components\Section::make('التوقيت والموقع')
                    ->schema([
                        Forms\Components\DateTimePicker::make('start_at')
                            ->label('تاريخ البدء'),
                        Forms\Components\DateTimePicker::make('due_at')
                            ->label('تاريخ الاستحقاق'),
                        Forms\Components\Select::make('location')
                            ->label('الموقع')
                            ->options([
                                'Sanaa' => 'صنعاء',
                                'Aden' => 'عدن',
                                'Taiz' => 'تعز',
                                'Hodeidah' => 'الحديدة',
                                'Ibb' => 'إب',
                                'Marib' => 'مأرب',
                                'Hadramout' => 'حضرموت',
                                'Dhamar' => 'ذمار',
                                'Amran' => 'عمران',
                                'Hajjah' => 'حجة',
                                'Al-Mahwit' => 'المحويت',
                                'Raymah' => 'ريمة',
                                'Al-Bayda' => 'البيضاء',
                                'Shabwah' => 'شبوة',
                                'Al-Jawf' => 'الجوف',
                                'Saada' => 'صعدة',
                                'Lahj' => 'لحج',
                                'Abyan' => 'أبين',
                                'Al-Mahrah' => 'المهرة',
                                'Socotra' => 'سقطرى',
                            ])
                            ->searchable()
                            ->preload()
                            ->columnSpanFull(),
                    ])->columns(2),

                Forms\Components\Section::make('الوصف')
                    ->schema([
                        Forms\Components\RichEditor::make('description')
                            ->label('الوصف')
                            // ->rows(3)
                            //### 
                            ->toolbarButtons([
                                'attachFiles',
                                'blockquote',
                                'bold',
                                'bulletList',
                                'h2',
                                'h3',
                                'italic',
                                'link',
                                'orderedList',
                                'redo',
                                'strike',
                                'underline',
                                'undo',
                            ])
                            ->disableGrammarly()
                            ->columnSpanFull(),
                        Forms\Components\FileUpload::make('attachments')
                            ->label('المرفقات')
                            ->image() // Treat as images
                            ->multiple()
                            ->disk('public') // Ensure public disk is used
                            ->visibility('public')
                            ->directory(function (Forms\Get $get) {
                                $date = now()->format('Y-m-d');
                                $title = $get('title') ?? 'new-task';
                                $title = str_replace(' ', '-', $title);
                                $title = preg_replace('/[^\p{L}\p{N}\-_]/u', '', $title);
                                return "tasks-attachments/{$date}_{$title}";
                            })
                            ->getUploadedFileNameForStorageUsing(function (Forms\Get $get, $file) {
                                $date = now()->format('Y-m-d');
                                $title = $get('title') ?? 'new-task';
                                $title = str_replace(' ', '-', $title);
                                $title = preg_replace('/[^\p{L}\p{N}\-_]/u', '', $title);
                                $extension = $file->getClientOriginalExtension();
                                $random = \Illuminate\Support\Str::random(5);
                                return "{$title}_{$date}_{$random}.{$extension}";
                            })
                            ->maxSize(2048)
                            ->panelLayout('grid')
                            ->reorderable()
                            ->openable()
                            ->moveFiles()
                            ->downloadable()
                            ->minFiles(2)
                            ->maxFiles(10)
                            ->validationMessages([
                                'min' => 'يجب إرفاق 2 ملفات صور على الأقل ياغالي 🤪 🤪 🤪 ',
                            ])
                            ->previewable(true)
                            ->uploadingMessage('جاري تحميل الصور  ........... (● ◡ ●) 👍👍')
                            // ->uploadedMessage('تم التحميل')
                            ->columnSpanFull(),
                    ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('title')
                    ->label('العنوان')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('priority')
                    ->label('الأولوية')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'low' => 'gray',
                        'medium' => 'info',
                        'high' => 'warning',
                        'urgent' => 'danger',
                    }),
                Tables\Columns\TextColumn::make('status')
                    ->label('الحالة')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'todo' => 'gray',
                        'pending' => 'gray',
                        'in_progress' => 'warning',
                        'done' => 'success',
                        'completed' => 'success',
                        'blocked' => 'danger',
                        default => 'gray',
                    }),
                Tables\Columns\TextColumn::make('assignees.name')
                    ->label('المكلفين')
                    ->badge()
                    ->searchable(),
                Tables\Columns\TextColumn::make('campaign.title')
                    ->label('الحملة')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('client.name')
                    ->label('العميل')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('due_at')
                    ->label('تاريخ الاستحقاق')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('progress_percentage')
                    ->label('الإنجاز')
                    ->suffix('%')
                    ->sortable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('الحالة')
                    ->options([
                        'todo' => 'للقيام',
                        'pending' => 'قيد الانتظار',
                        'in_progress' => 'قيد التنفيذ',
                        'done' => 'منجزة',
                        'completed' => 'مكتملة',
                        'blocked' => 'معلقة',
                    ]),
                Tables\Filters\SelectFilter::make('priority')
                    ->label('الأولوية')
                    ->options([
                        'low' => 'منخفضة',
                        'medium' => 'متوسطة',
                        'high' => 'عالية',
                        'urgent' => 'عاجلة',
                    ]),
                Tables\Filters\SelectFilter::make('assignees')
                    ->label('المكلف')
                    ->relationship('assignees', 'name')
                    ->multiple()
                    ->preload(),
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListTasks::route('/'),
            'create' => Pages\CreateTask::route('/create'),
            'view' => Pages\ViewTask::route('/{record}'),
            'edit' => Pages\EditTask::route('/{record}/edit'),
        ];
    }
}
