<?php

namespace App\Filament\Admin\Resources;

use App\Filament\Admin\Resources\ClientResource\Pages;
use App\Filament\Admin\Resources\ClientResource\RelationManagers;
use App\Models\Client;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Dotswan\MapPicker\Fields\Map;

class ClientResource extends Resource
{
    protected static ?string $model = Client::class;

    protected static ?string $navigationIcon = 'heroicon-o-user-group';

    protected static ?string $navigationLabel = 'العملاء';

    protected static ?string $navigationGroup = 'إدارة العملاء';

    protected static ?int $navigationSort = 1;
    protected static ?string $modelLabel = 'عميل';

    protected static ?string $pluralModelLabel = 'العملاء';


    public static function getNavigationBadge(): ?string
    {
        return static::getModel()::count();
    }

    public static function getNavigationBadgeColor(): ?string
    {
        return static::getModel()::count() > 10 ? 'warning' : 'primary';
    }


    protected static ?string $navigationBadgeTooltip = 'The number of users';



    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('المعلومات الأساسية')
                    ->schema([
                        Forms\Components\Toggle::make('is_main_client')
                            ->label('هل هذا عميل رئيسي / شركة؟')
                            ->live()
                            ->columnSpanFull(),

                        Forms\Components\Select::make('parent_id')
                            ->label('العميل الرئيسي (للشركات والفروع)')
                            ->relationship('parent', 'name')
                            ->searchable()
                            ->preload()
                            ->visible(fn(Forms\Get $get) => !$get('is_main_client')),

                        Forms\Components\TextInput::make('name')
                            ->label('الاسم')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\Select::make('type')
                            ->label('نوع العميل')
                            ->options([
                                'merchant' => 'تاجر',
                                'workshop' => 'ورشة',
                                'distributor' => 'موزع',
                                'company' => 'شركة',
                                'individual' => 'فرد',
                            ]),
                        Forms\Components\Select::make('status')
                            ->label('حالة العلاقة')
                            ->options([
                                'active' => 'Active - نشط',
                                'cold' => 'Cold - بارد',
                                'lost' => 'Lost - مفقود',
                            ])
                            ->default('active'),
                        Forms\Components\TextInput::make('classification_id')
                            ->label('التصنيف')
                            ->numeric(),
                        Forms\Components\Repeater::make('phone')
                            ->label('أرقام الهاتف')
                            ->schema([
                                Forms\Components\TextInput::make('number')
                                    ->hiddenLabel()
                                    ->required()
                                    ->numeric()
                                    ->prefix('+967')
                                    ->length(9)
                                    ->regex('/^[0-9]{9}$/')
                                    ->placeholder('77xxxxxxx')
                                    ->mask('999999999')
                            ])
                            ->addActionLabel('إضافة رقم آخر')
                            ->defaultItems(1)
                            ->grid(2)
                            ->columnSpanFull()
                            ->formatStateUsing(fn($state) => collect($state ?? [])->map(fn($item) => ['number' => $item])->toArray())
                            ->dehydrateStateUsing(fn($state) => collect($state ?? [])->pluck('number')->toArray()),
                        Forms\Components\TextInput::make('email')
                            ->label('البريد الإلكتروني')
                            ->email()
                            ->maxLength(255),
                        Forms\Components\Select::make('category')
                            ->label('الفئة')
                            ->options([
                                'تاجر دراجات نارية' => 'تاجر دراجات نارية',
                                'ورشة / ميكانيكي' => 'ورشة / ميكانيكي',
                                'محل قطع غيار' => 'محل قطع غيار',
                                'مطعم' => 'مطعم',
                                'صيدلية' => 'صيدلية',
                                'سوبر ماركت' => 'سوبر ماركت',
                                'أخرى' => 'أخرى',
                            ]),
                        Forms\Components\Select::make('importance')
                            ->label('الأهمية')
                            ->options([
                                'A' => 'A - عالية',
                                'B' => 'B - متوسطة',
                                'C' => 'C - منخفضة',
                            ]),
                        Forms\Components\Toggle::make('is_agent')
                            ->label('وكيل')
                            ->default(false),
                    ])->columns(2),

                Forms\Components\Section::make('الفروع التابعة')
                    ->schema([
                        Forms\Components\Repeater::make('children')
                            ->relationship()
                            ->schema([
                                Forms\Components\TextInput::make('name')
                                    ->label('اسم الفرع')
                                    ->required(),
                                Forms\Components\TagsInput::make('phone')
                                    ->label('أرقام الهاتف'),
                                Forms\Components\TextInput::make('address')
                                    ->label('العنوان'),
                            ])
                            ->addActionLabel('إضافة فرع تابع')
                            ->defaultItems(0),
                    ])
                    ->visible(fn(Forms\Get $get) => $get('is_main_client')),

                Forms\Components\Section::make('موظفي العميل')
                    ->schema([
                        Forms\Components\Repeater::make('employees')
                            ->relationship()
                            ->schema([
                                Forms\Components\TextInput::make('name')
                                    ->label('الاسم')
                                    ->required(),
                                Forms\Components\TextInput::make('role')
                                    ->label('المسمى الوظيفي')
                                    ->placeholder('مثال: مهندس، مدير مشتريات'),
                                Forms\Components\TagsInput::make('phone')
                                    ->label('أرقام الهاتف'),
                                Forms\Components\TextInput::make('email')
                                    ->label('البريد الإلكتروني')
                                    ->email(),
                                Forms\Components\Toggle::make('is_contact_point')
                                    ->label('نقطة تواصل')
                                    ->default(false),
                            ])
                            ->columns(2)
                            ->defaultItems(0)
                            ->addActionLabel('إضافة موظف'),
                    ]),

                Forms\Components\Section::make('الموقع')
                    ->schema([
                        Forms\Components\Select::make('province')
                            ->label('المحافظة')
                            ->options(\App\Helpers\YemenGeo::getProvinces())
                            ->live()
                            ->afterStateUpdated(fn(Forms\Set $set) => $set('district', null)),
                        Forms\Components\Select::make('district')
                            ->label('المديرية')
                            ->options(fn(Forms\Get $get) => \App\Helpers\YemenGeo::getDistricts($get('province') ?? '')),
                        Forms\Components\Textarea::make('address')
                            ->label('العنوان')
                            ->rows(2),
                        Forms\Components\Actions::make([
                            Forms\Components\Actions\Action::make('captureLocation')
                                ->label(fn(Forms\Get $get) => $get('gps_location') ? 'تم تحديد الموقع بنجاح ✓' : 'اضغط لتحديد الموقع الحالي')
                                ->icon('heroicon-m-map-pin')
                                ->color(fn(Forms\Get $get) => $get('gps_location') ? 'success' : 'primary')
                                ->action(function () {
                                    // This is handled by AlpineJS
                                })
                                ->extraAttributes([
                                    'class' => 'w-full',
                                    'x-on:click' => <<<'JS'
                                        if (!navigator.geolocation) {
                                            new FilamentNotification()
                                                .title('خطأ')
                                                .body('المتصفح لا يدعم تحديد الموقع')
                                                .danger()
                                                .send();
                                            return;
                                        }

                                        $el.disabled = true;
                                        // Add spinner icon
                                        $el.innerHTML = '<svg class="animate-spin h-5 w-5 mr-3 inline-block" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg> جاري تحديد الموقع...';

                                        navigator.geolocation.getCurrentPosition(
                                            (position) => {
                                                $wire.set('data.gps_location', {
                                                    lat: position.coords.latitude,
                                                    lng: position.coords.longitude
                                                });
                                                
                                                // Success Notification
                                                new FilamentNotification()
                                                    .title('تم بنجاح')
                                                    .body('تم تحديد موقعك بدقة')
                                                    .success()
                                                    .send();

                                                // The button will be re-rendered by Livewire with the new "Success" state defined in PHP
                                            },
                                            (error) => {
                                                $el.disabled = false;
                                                $el.innerText = 'فشل - حاول مرة أخرى';
                                                
                                                let msg = 'حدث خطأ غير معروف.';
                                                if (error.code === 1) msg = 'تم رفض الإذن. يرجى السماح للموقع من المتصفح.';
                                                else if (error.code === 2) msg = 'الموقع غير متوفر.';
                                                else if (error.code === 3) msg = 'انتهت المهلة.';

                                                new FilamentNotification()
                                                    .title('فشل تحديد الموقع')
                                                    .body(msg)
                                                    .danger()
                                                    .send();
                                            },
                                            { enableHighAccuracy: true, timeout: 10000 }
                                        )
                                    JS,
                                ]),
                        ])->columnSpanFull(),
                        Forms\Components\Hidden::make('gps_location')
                            ->live(),
                        // ->columnSpanFull(),
                    ])->columns(2),

                Forms\Components\Section::make('الصور والمرفقات')
                    ->schema([
                        Forms\Components\FileUpload::make('profile_image')
                            ->label('صورة الملف الشخصي')
                            ->image()
                            ->directory(function (Forms\Get $get) {
                                $date = now()->format('Y-m-d');
                                $name = $get('name') ?? 'new-client';
                                $name = str_replace(' ', '-', $name);
                                $name = preg_replace('/[^\p{L}\p{N}\-_]/u', '', $name);
                                return "clients/profiles/{$date}_{$name}";
                            })
                            ->getUploadedFileNameForStorageUsing(function (Forms\Get $get, $file) {
                                $date = now()->format('Y-m-d');
                                $name = $get('name') ?? 'new-client';
                                $name = str_replace(' ', '-', $name);
                                $name = preg_replace('/[^\p{L}\p{N}\-_]/u', '', $name);
                                $extension = $file->getClientOriginalExtension();
                                $random = \Illuminate\Support\Str::random(5);
                                return "{$name}_profile_{$date}_{$random}.{$extension}";
                            })
                            ->maxSize(2048),
                        Forms\Components\FileUpload::make('images')
                            ->label('صور المحل/الموقع')
                            ->image()
                            ->multiple()
                            ->directory(function (Forms\Get $get) {
                                $date = now()->format('Y-m-d');
                                $name = $get('name') ?? 'new-client';
                                $name = str_replace(' ', '-', $name);
                                $name = preg_replace('/[^\p{L}\p{N}\-_]/u', '', $name);
                                return "clients/galleries/{$date}_{$name}";
                            })
                            ->getUploadedFileNameForStorageUsing(function (Forms\Get $get, $file) {
                                $date = now()->format('Y-m-d');
                                $name = $get('name') ?? 'new-client';
                                $name = str_replace(' ', '-', $name);
                                $name = preg_replace('/[^\p{L}\p{N}\-_]/u', '', $name);
                                $extension = $file->getClientOriginalExtension();
                                $random = \Illuminate\Support\Str::random(5);
                                return "{$name}_gallery_{$date}_{$random}.{$extension}";
                            })
                            ->maxSize(2048),
                    ])->columns(2),

                Forms\Components\Section::make('معلومات إضافية')
                    ->schema([
                        Forms\Components\Select::make('agent_id')
                            ->label('الوكيل')
                            ->relationship('agent', 'name')
                            ->searchable()
                            ->preload(),
                        // Branch ID removed as per request
                        // Forms\Components\Select::make('roles')
                        //     ->label('الأدوار')
                        //     ->relationship('roles', 'name')
                        //     ->multiple()
                        //     ->preload()
                        //     ->searchable(),
                        Forms\Components\Select::make('loyalty_level')
                            ->label('مستوى الولاء')
                            ->options([
                                'gold' => 'ذهبي',
                                'silver' => 'فضي',
                                'bronze' => 'برونزي',
                            ]),
                        Forms\Components\DateTimePicker::make('last_visit')
                            ->label('آخر زيارة'),
                        Forms\Components\Textarea::make('notes')
                            ->label('ملاحظات')
                            ->rows(3)
                            ->columnSpanFull(),
                    ])->columns(2),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('الاسم')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('parent.name')
                    ->label('تابع لـ')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('type')
                    ->label('النوع')
                    ->searchable()
                    ->badge(),
                Tables\Columns\TextColumn::make('status')
                    ->label('الحالة')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'active' => 'success',
                        'cold' => 'warning',
                        'lost' => 'danger',
                        default => 'gray',
                    }),
                Tables\Columns\TextColumn::make('phone')
                    ->label('الهاتف')
                    ->prefix('+967')
                    ->searchable(),
                Tables\Columns\TextColumn::make('category')
                    ->label('الفئة')
                    ->searchable()
                    ->badge(),
                Tables\Columns\TextColumn::make('importance')
                    ->label('الأهمية')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'A' => 'success',
                        'B' => 'warning',
                        'C' => 'danger',
                        default => 'gray',
                    }),
                Tables\Columns\IconColumn::make('is_agent')
                    ->label('وكيل')
                    ->boolean(),
                Tables\Columns\TextColumn::make('province')
                    ->label('المحافظة')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('district')
                    ->label('المديرية')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('agent.name')
                    ->label('الوكيل')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('branch.name')
                    ->label('الفرع')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('تاريخ الإنشاء')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('createdBy.name')
                    ->label('أضيف بواسطة')
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('category')
                    ->label('الفئة')
                    ->options([
                        'تاجر دراجات نارية' => 'تاجر دراجات نارية',
                        'ورشة / ميكانيكي' => 'ورشة / ميكانيكي',
                        'محل قطع غيار' => 'محل قطع غيار',
                    ]),
                Tables\Filters\SelectFilter::make('importance')
                    ->label('الأهمية')
                    ->options([
                        'A' => 'A',
                        'B' => 'B',
                        'C' => 'C',
                    ]),
                Tables\Filters\TernaryFilter::make('is_agent')
                    ->label('وكيل'),
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

    public static function infolist(\Filament\Infolists\Infolist $infolist): \Filament\Infolists\Infolist
    {
        return $infolist
            ->schema([
                \Filament\Infolists\Components\Section::make()
                    ->schema([
                        \Filament\Infolists\Components\Split::make([
                            \Filament\Infolists\Components\Grid::make(1)
                                ->schema([
                                    \Filament\Infolists\Components\ImageEntry::make('profile_image')
                                        ->hiddenLabel()
                                        ->circular()
                                        ->grow(false),
                                ])->grow(false),
                            \Filament\Infolists\Components\Grid::make(2)
                                ->schema([
                                    \Filament\Infolists\Components\Group::make([
                                        \Filament\Infolists\Components\TextEntry::make('name')
                                            ->label('الاسم')
                                            ->weight('bold')
                                            ->size('lg'),
                                        \Filament\Infolists\Components\TextEntry::make('type')
                                            ->label('النوع')
                                            ->badge(),
                                        \Filament\Infolists\Components\TextEntry::make('status')
                                            ->label('الحالة')
                                            ->badge()
                                            ->color(fn(string $state): string => match ($state) {
                                                'active' => 'success',
                                                'cold' => 'warning',
                                                'lost' => 'danger',
                                                default => 'gray',
                                            }),
                                    ]),
                                    \Filament\Infolists\Components\Group::make([
                                        \Filament\Infolists\Components\TextEntry::make('email')
                                            ->label('البريد الإلكتروني')
                                            ->icon('heroicon-m-envelope'),
                                        \Filament\Infolists\Components\TextEntry::make('phone')
                                            ->label('الهاتف')
                                            ->icon('heroicon-m-phone')
                                            ->listWithLineBreaks()
                                            ->formatStateUsing(fn($state) => is_array($state) ? implode("\n", $state) : $state),
                                        \Filament\Infolists\Components\TextEntry::make('address')
                                            ->label('العنوان')
                                            ->icon('heroicon-m-map-pin'),
                                    ]),
                                ]),
                        ])->from('md'),
                    ]),

                \Filament\Infolists\Components\Section::make('التفاصيل')
                    ->schema([
                        \Filament\Infolists\Components\TextEntry::make('category')
                            ->label('الفئة')
                            ->badge(),
                        \Filament\Infolists\Components\TextEntry::make('importance')
                            ->label('الأهمية')
                            ->badge()
                            ->color(fn(string $state): string => match ($state) {
                                'A' => 'success',
                                'B' => 'warning',
                                'C' => 'danger',
                                default => 'gray',
                            }),
                        \Filament\Infolists\Components\IconEntry::make('is_agent')
                            ->label('وكيل')
                            ->boolean(),
                        \Filament\Infolists\Components\TextEntry::make('loyalty_level')
                            ->label('مستوى الولاء')
                            ->badge()
                            ->color('info'),
                        \Filament\Infolists\Components\TextEntry::make('last_visit')
                            ->label('آخر زيارة')
                            ->dateTime(),
                        \Filament\Infolists\Components\TextEntry::make('agent.name')
                            ->label('الوكيل المسؤول'),
                    ])->columns(3),

                \Filament\Infolists\Components\Section::make('الموقع الجغرافي')
                    ->schema([
                        \Filament\Infolists\Components\TextEntry::make('province')
                            ->label('المحافظة'),
                        \Filament\Infolists\Components\TextEntry::make('district')
                            ->label('المديرية'),
                        \Filament\Infolists\Components\TextEntry::make('gps_location')
                            ->label('الإحداثيات')
                            ->formatStateUsing(fn($state) => is_array($state) ? (($state['lat'] ?? '?') . ', ' . ($state['lng'] ?? '?')) : $state)
                            ->url(fn($state) => (is_array($state) && isset($state['lat'], $state['lng'])) ? "https://www.google.com/maps/search/?api=1&query={$state['lat']},{$state['lng']}" : null)
                            ->openUrlInNewTab()
                            ->color('primary'),
                    ])->columns(3),

                \Filament\Infolists\Components\Section::make('الصور')
                    ->schema([
                        \Filament\Infolists\Components\ViewEntry::make('images')
                            ->view('filament.infolists.client-images')
                            ->hiddenLabel(),
                    ])
                    ->collapsible(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListClients::route('/'),
            'create' => Pages\CreateClient::route('/create'),
            'view' => Pages\ViewClient::route('/{record}'),
            'edit' => Pages\EditClient::route('/{record}/edit'),
        ];
    }
}
