﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

////////////////////////////////////////////////////////////////////////////////
// ПРОГРАММНЫЙ ИНТЕРФЕЙС

#Область ПрограммныйИнтерфейс

// Возвращает параметры исполнения отчета.
//
// Возвращаемое значение:
//  Структура
//
Функция ПолучитьПараметрыИсполненияОтчета() Экспорт
	
	ПараметрыИсполненияОтчета = Новый Структура();
	ПараметрыИсполненияОтчета.Вставить("ИспользоватьПередКомпоновкойМакета",          Истина);
	ПараметрыИсполненияОтчета.Вставить("ИспользоватьПослеКомпоновкиМакета",           Истина);
	ПараметрыИсполненияОтчета.Вставить("ИспользоватьПослеВыводаРезультата",           Истина);
	ПараметрыИсполненияОтчета.Вставить("ИспользоватьДанныеРасшифровки",               Истина);
	ПараметрыИсполненияОтчета.Вставить("ИспользоватьВнешниеНаборыДанных",             Истина);
	ПараметрыИсполненияОтчета.Вставить("ИспользоватьРасширенныеПараметрыРасшифровки", Ложь);
	
	Возврат ПараметрыИсполненияОтчета;
	
КонецФункции

// Формирует текст, выводимый в заголовке отчета.
//
// Параметры:
//  ПараметрыОтчета - Структура - подробнее см. модуль формы отчета, функция ПодготовитьПараметрыОтчетаНаСервере().
//  ОрганизацияВНачале - Булево - флаг, используемый для вывода представления организации в начале текста,
//                                если организацию нужно выводить в тексте заголовка.
//
// Возвращаемое значение:
//   Строка      - текст заголовка с учётом периода.
//
Функция ПолучитьТекстЗаголовка(ПараметрыОтчета, ОрганизацияВНачале = Истина) Экспорт
	
	Возврат "Сверка сумм оплат в блоке ЖКХ и БП (по контрагентам)"
			+ УПЖКХ_ТиповыеМетодыКлиентСервер.ПолучитьПредставлениеПериода(ПараметрыОтчета.НачалоПериода, ПараметрыОтчета.КонецПериода);
	
КонецФункции

// Функция возвращает внешние наборы данных.
//
// Параметры:
//  ПараметрыОтчета - Структура - Содержит ключи:
//    * ИдентификаторОтчета - Строка - Имя отчета, как оно указано в метаданных.
//    * СхемаКомпоновкиДанных - СхемаКомпоновкиДанных - Схема отчета.
//    * НастройкиКомпоновкиДанных - НастройкиКомпоновкиДанных - Настройки отчета.
//  МакетКомпоновки	 - МакетКомпоновкиДанных - сформированный макет компоновки данных.
// 
// Возвращаемое значение:
//  Структура - Внешние наборы данных.
//
Функция ПолучитьВнешниеНаборыДанных(ПараметрыОтчета, МакетКомпоновки) Экспорт
	
	Возврат Новый Структура();
	
КонецФункции

// В процедуре можно доработать компоновщик перед выводом в отчет. Изменения сохранены не будут.
//
// Параметры:
//  ПараметрыОтчета - Структура - подробнее см. модуль формы отчета, функция ПодготовитьПараметрыОтчетаНаСервере().
//  Схема        - СхемаКомпоновкиДанных - описание получаемых данных.
//  КомпоновщикНастроек - КомпоновщикНастроекКомпоновкиДанных - связь настроек компоновки данных и схемы компоновки.
//
Процедура ПередКомпоновкойМакета(ПараметрыОтчета, Схема, КомпоновщикНастроек) Экспорт
	
	Если ЗначениеЗаполнено(ПараметрыОтчета.НачалоПериода) Тогда
		УПЖКХ_ТиповыеМетодыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "НачПериода",  ПараметрыОтчета.НачалоПериода);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПараметрыОтчета.КонецПериода) Тогда
		УПЖКХ_ТиповыеМетодыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "КонПериода",  ПараметрыОтчета.КонецПериода);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПараметрыОтчета.Организация) Тогда
		УПЖКХ_ТиповыеМетодыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "Организация", ПараметрыОтчета.Организация);
	КонецЕсли;
	
	Если ПараметрыОтчета.Свойство("ВсеОплаты") Тогда
		УПЖКХ_ТиповыеМетодыКлиентСервер.УстановитьПараметр(КомпоновщикНастроек, "ВсеОплаты",   ПараметрыОтчета.ВсеОплаты);
	КонецЕсли;
	
	УПЖКХ_ТиповыеМетодыВызовСервера.ДобавитьДополнительныеПоля(ПараметрыОтчета, КомпоновщикНастроек);
	
КонецПроцедуры

// В процедуре можно уточнить особенности вывода данных в отчет.
//
// Параметры:
//  ПараметрыОтчета - Структура - подробнее см. модуль формы отчета, функция ПодготовитьПараметрыОтчетаНаСервере().
//  МакетКомпоновки - МакетКомпоновкиДанных - описание выводимых данных.
//
Процедура ПослеКомпоновкиМакета(ПараметрыОтчета, МакетКомпоновки) Экспорт
	// заглушка
КонецПроцедуры

// В процедуре можно изменить табличный документ после вывода в него данных.
//
// Параметры:
//  ПараметрыОтчета - Структура - подробнее см. модуль формы отчета, функция ПодготовитьПараметрыОтчетаНаСервере().
//  Результат    - ТабличныйДокумент - сформированный отчет.
//
Процедура ПослеВыводаРезультата(ПараметрыОтчета, Результат) Экспорт
	
	УПЖКХ_ТиповыеМетодыВызовСервера.ОбработкаРезультатаОтчета(ПараметрыОтчета.ИдентификаторОтчета, Результат);
	
КонецПроцедуры

// Настройки размещения в панели отчетов.
//
// Параметры:
//   Настройки - Коллекция - Передается "как есть" из ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//   ОписаниеОтчета - СтрокаДереваЗначений - Настройки этого отчета,
//       уже сформированные при помощи функции ВариантыОтчетов.ОписаниеОтчета() и готовые к изменению.
//
Процедура НастроитьВариантыОтчета(Настройки, ОписаниеОтчета) Экспорт
	// заглушка
КонецПроцедуры

// Заполняет описание настроек отчета в коллекции Настройки
//
// Параметры:
//   Настройки - Коллекция - Передается "как есть" из ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов().
//
Процедура НастройкиОтчета(Настройки) Экспорт
	
	Схема = ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
	Для Каждого Вариант Из Схема.ВариантыНастроек Цикл
		Настройки.ОписаниеВариантов.Вставить(Вариант.Имя, Вариант.Представление);
	КонецЦикла;
	
КонецПроцедуры

// Заполняет параметры расшифровки ячейки отчета.
//
// Параметры:
//	Адрес - Строка - Адрес временного хранилища с данными расшифровки отчета.
//	Расшифровка - Произвольный - Значения полей расшифровки.
//	ПараметрыРасшифровки - Структура - Коллеккция параметров расшифроки, которую требуется заполнить. 
//		Подробнее см. БухгалтерскиеОтчетыВызовСервера.ПолучитьМассивПолейРасшифровки()
//
Процедура ЗаполнитьПараметрыРасшифровкиОтчета(Адрес, Расшифровка, ПараметрыРасшифровки) Экспорт
	// заглушка
КонецПроцедуры

#КонецОбласти

#КонецЕсли