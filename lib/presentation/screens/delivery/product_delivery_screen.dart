import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class ProductDeliveryScreen extends StatefulWidget {
  const ProductDeliveryScreen({super.key});

  @override
  State<ProductDeliveryScreen> createState() => _ProductDeliveryScreenState();
}

class _ProductDeliveryScreenState extends State<ProductDeliveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _deliveryAddressController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedCategory = 'طعام';
  String _selectedPriority = 'عادي';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<String> _categories = [
    'طعام',
    'مشروبات',
    'حلويات',
    'فواكه',
    'خضروات',
    'أخرى',
  ];

  final List<String> _priorities = [
    'عاجل',
    'عادي',
    'غير عاجل',
  ];

  @override
  void dispose() {
    _productNameController.dispose();
    _productDescriptionController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _deliveryAddressController.dispose();
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitDelivery() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement delivery submission logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال طلب التوصيل بنجاح'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
      context.go(AppRouter.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب توصيل منتج'),
        backgroundColor: AppTheme.white,
        foregroundColor: AppTheme.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRouter.home),
        ),
      ),
      backgroundColor: AppTheme.grey50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppTheme.spacingL),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen,
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.delivery_dining,
                      size: 48,
                      color: AppTheme.white,
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    Text(
                      'طلب توصيل منتج جديد',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppTheme.white,
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Text(
                      'املأ البيانات المطلوبة لإرسال طلب التوصيل',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.white.withOpacity(0.9),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppTheme.spacingXL),

              // Product Information Section
              _buildSectionHeader('معلومات المنتج'),
              const SizedBox(height: AppTheme.spacingM),

              CustomTextField(
                controller: _productNameController,
                labelText: 'اسم المنتج',
                hintText: 'أدخل اسم المنتج',
                prefixIcon: const Icon(Icons.inventory),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم المنتج';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppTheme.spacingM),

              CustomTextField(
                controller: _productDescriptionController,
                labelText: 'وصف المنتج',
                hintText: 'أدخل وصف المنتج (اختياري)',
                prefixIcon: const Icon(Icons.description),
                maxLines: 3,
              ),

              const SizedBox(height: AppTheme.spacingM),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _quantityController,
                      labelText: 'الكمية',
                      hintText: '1',
                      prefixIcon: const Icon(Icons.numbers),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال الكمية';
                        }
                        if (int.tryParse(value) == null) {
                          return 'يرجى إدخال رقم صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: CustomTextField(
                      controller: _priceController,
                      labelText: 'السعر (ريال)',
                      hintText: '0.00',
                      prefixIcon: const Icon(Icons.attach_money),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال السعر';
                        }
                        if (double.tryParse(value) == null) {
                          return 'يرجى إدخال رقم صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingM),

              // Category Dropdown
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: AppTheme.grey100,
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                  border: Border.all(color: AppTheme.grey300),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'فئة المنتج',
                    prefixIcon:
                        Icon(Icons.category, color: AppTheme.primaryGreen),
                    border: InputBorder.none,
                  ),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
              ),

              const SizedBox(height: AppTheme.spacingXL),

              // Customer Information Section
              _buildSectionHeader('معلومات العميل'),
              const SizedBox(height: AppTheme.spacingM),

              CustomTextField(
                controller: _customerNameController,
                labelText: 'اسم العميل',
                hintText: 'أدخل اسم العميل',
                prefixIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال اسم العميل';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppTheme.spacingM),

              CustomTextField(
                controller: _customerPhoneController,
                labelText: 'رقم الهاتف',
                hintText: 'أدخل رقم الهاتف',
                prefixIcon: const Icon(Icons.phone),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال رقم الهاتف';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppTheme.spacingM),

              CustomTextField(
                controller: _deliveryAddressController,
                labelText: 'عنوان التوصيل',
                hintText: 'أدخل عنوان التوصيل الكامل',
                prefixIcon: const Icon(Icons.location_on),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال عنوان التوصيل';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppTheme.spacingXL),

              // Delivery Information Section
              _buildSectionHeader('معلومات التوصيل'),
              const SizedBox(height: AppTheme.spacingM),

              // Priority Dropdown
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: AppTheme.grey100,
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                  border: Border.all(color: AppTheme.grey300),
                ),
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedPriority,
                  decoration: const InputDecoration(
                    labelText: 'أولوية التوصيل',
                    prefixIcon:
                        Icon(Icons.priority_high, color: AppTheme.primaryGreen),
                    border: InputBorder.none,
                  ),
                  items: _priorities.map((String priority) {
                    return DropdownMenuItem<String>(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPriority = newValue!;
                    });
                  },
                ),
              ),

              const SizedBox(height: AppTheme.spacingM),

              // Date and Time Selection
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _selectDate,
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacingM),
                        decoration: BoxDecoration(
                          color: AppTheme.grey100,
                          borderRadius: BorderRadius.circular(AppTheme.radiusL),
                          border: Border.all(color: AppTheme.grey300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                color: AppTheme.primaryGreen),
                            const SizedBox(width: AppTheme.spacingS),
                            Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: GestureDetector(
                      onTap: _selectTime,
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacingM),
                        decoration: BoxDecoration(
                          color: AppTheme.grey100,
                          borderRadius: BorderRadius.circular(AppTheme.radiusL),
                          border: Border.all(color: AppTheme.grey300),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: AppTheme.primaryGreen),
                            const SizedBox(width: AppTheme.spacingS),
                            Text(
                              _selectedTime.format(context),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingM),

              CustomTextField(
                controller: _notesController,
                labelText: 'ملاحظات إضافية',
                hintText: 'أدخل أي ملاحظات إضافية (اختياري)',
                prefixIcon: const Icon(Icons.note),
                maxLines: 3,
              ),

              const SizedBox(height: AppTheme.spacingXXL),

              // Submit Button
              CustomButton(
                text: 'إرسال طلب التوصيل',
                onPressed: _submitDelivery,
                backgroundColor: AppTheme.primaryGreen,
              ),

              const SizedBox(height: AppTheme.spacingL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM,
        vertical: AppTheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: AppTheme.primaryGreen,
            size: 20,
          ),
          const SizedBox(width: AppTheme.spacingS),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
