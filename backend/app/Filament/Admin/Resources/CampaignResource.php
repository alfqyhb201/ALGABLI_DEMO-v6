<?php

namespace App\Filament\Admin\Resources;

use App\Filament\Admin\Resources\CampaignResource\Pages;
use App\Filament\Admin\Resources\CampaignResource\RelationManagers;
use App\Models\Campaign;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class CampaignResource extends Resource
{
    protected static ?string $model = Campaign::class;

    protected static ?string $navigationIcon = 'heroicon-o-megaphone';
    
    protected static ?string $navigationLabel = 'الحملات';
    
    protected static ?string $modelLabel = 'حملة';
    
    protected static ?string $pluralModelLabel = 'الحملات';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('تفاصيل الحملة')
                    ->schema([
                        Forms\Components\TextInput::make('title')
                            ->label('عنوان الحملة')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\Select::make('campaign_type')
                            ->label('نوع الحملة')
                            ->options([
                                'social_media' => 'تواصل اجتماعي',
                                'email' => 'بريد إلكتروني',
                                'sms' => 'رسائل نصية',
                                'field_visit' => 'زيارة ميدانية',
                                'other' => 'أخرى',
                            ]),
                        Forms\Components\Select::make('status')
                            ->label('الحالة')
                            ->options([
                                'draft' => 'مسودة',
                                'active' => 'نشطة',
                                'completed' => 'مكتملة',
                                'cancelled' => 'ملغاة',
                            ])
                            ->default('draft')
                            ->required(),
                        Forms\Components\Select::make('owner_id')
                            ->label('المسؤول')
                            ->relationship('owner', 'name')
                            ->searchable()
                            ->preload(),
                    ])->columns(2),

                Forms\Components\Section::make('الجدول الزمني والميزانية')
                    ->schema([
                        Forms\Components\DatePicker::make('start_date')
                            ->label('تاريخ البدء'),
                        Forms\Components\DatePicker::make('end_date')
                            ->label('تاريخ الانتهاء'),
                        Forms\Components\TextInput::make('budget')
                            ->label('الميزانية')
                            ->numeric()
                            ->prefix('$'),
                    ])->columns(3),

                Forms\Components\Section::make('معلومات إضافية')
                    ->schema([
                        Forms\Components\Textarea::make('objective')
                            ->label('الهدف')
                            ->rows(3)
                            ->columnSpanFull(),
                        Forms\Components\KeyValue::make('result_summary')
                            ->label('ملخص النتائج')
                            ->columnSpanFull(),
                    ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('code')
                    ->label('الرمز')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('title')
                    ->label('العنوان')
                    ->searchable(),
                Tables\Columns\TextColumn::make('campaign_type')
                    ->label('النوع')
                    ->badge(),
                Tables\Columns\TextColumn::make('status')
                    ->label('الحالة')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'draft' => 'gray',
                        'active' => 'success',
                        'completed' => 'info',
                        'cancelled' => 'danger',
                    }),
                Tables\Columns\TextColumn::make('start_date')
                    ->label('تاريخ البدء')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('end_date')
                    ->label('تاريخ الانتهاء')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('budget')
                    ->label('الميزانية')
                    ->money('USD')
                    ->sortable(),
                Tables\Columns\TextColumn::make('owner.name')
                    ->label('المسؤول')
                    ->searchable(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('الحالة')
                    ->options([
                        'draft' => 'مسودة',
                        'active' => 'نشطة',
                        'completed' => 'مكتملة',
                        'cancelled' => 'ملغاة',
                    ]),
                Tables\Filters\SelectFilter::make('campaign_type')
                    ->label('النوع')
                    ->options([
                        'social_media' => 'تواصل اجتماعي',
                        'email' => 'بريد إلكتروني',
                        'sms' => 'رسائل نصية',
                        'field_visit' => 'زيارة ميدانية',
                        'other' => 'أخرى',
                    ]),
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
            'index' => Pages\ListCampaigns::route('/'),
            'create' => Pages\CreateCampaign::route('/create'),
            'view' => Pages\ViewCampaign::route('/{record}'),
            'edit' => Pages\EditCampaign::route('/{record}/edit'),
        ];
    }
}
