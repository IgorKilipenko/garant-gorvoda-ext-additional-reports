﻿// Гарант+ Килипенко 03.02.2025 [F00234067] Отчет Потребление по нормам ++
#Область ОбработчикиСобытий

Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
    СтандартнаяОбработка = Ложь;
    
    ИнициализироватьПараметры();
    
    КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
    МакетКомпоновки = КомпоновщикМакета.Выполнить(ЭтотОбъект.СхемаКомпоновкиДанных,
            ЭтотОбъект.КомпоновщикНастроек.ПолучитьНастройки(), ДанныеРасшифровки);
    
    ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
    МВТ = Новый МенеджерВременныхТаблиц;
    
    ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина, Истина, МВТ);

    ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВТабличныйДокумент;
    ПроцессорВывода.УстановитьДокумент(ДокументРезультат);
    ПроцессорВывода.Вывести(ПроцессорКомпоновки);
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытий
// Гарант+ Килипенко 03.02.2025 [F00234067] Отчет Потребление по нормам --

// Гарант+ Килипенко 03.02.2025 [F00234067] Отчет Потребление по нормам ++
#Область СлужебныеПроцедурыИФункции

// Устарела. Не используется
Функция Удалить_ПолучитьСчетаУчетаВзаиморасчетов()
    РезультатФункции = Новый СписокЗначений;

    ТаблицаСчетов = УчетВзаиморасчетов.ПолучитьТаблицуСчетовУчетаВзаиморасчетов(Истина, Ложь);

    Для Каждого СтрокаСчета Из ТаблицаСчетов Цикл
        РезультатФункции.Добавить(СтрокаСчета.СчетРасчетов);
    КонецЦикла;

    Возврат РезультатФункции;
КонецФункции

Функция ПолучитьОсновнойНаборДанных()
    Возврат ЭтотОбъект.СхемаКомпоновкиДанных.НаборыДанных.НаборДанных1;
КонецФункции

Процедура ИнициализироватьПараметры()
    // Установка границ периода отчета
    УточнитьПараметрыПериодаОтчета();
    
    БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
        ЭтотОбъект.КомпоновщикНастроек, "УслугаКанализация", ГП_РаботаСУслугами.ПолучитьУслугуКанализации().Ссылка);

    БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
        ЭтотОбъект.КомпоновщикНастроек, "УслугаНВ", ГП_РаботаСУслугами.ПолучитьУслугуНегативногоВоздействияНаЦСВ().Ссылка);
КонецПроцедуры

Функция УточнитьПараметрыПериодаОтчета()
    РезультатФункции = Новый Структура("НачалоПериода, КонецПериода", Дата(1, 1, 1), Дата(1, 1, 1));

    ПараметрПериодОтчета =
        БухгалтерскиеОтчетыКлиентСервер.ПолучитьПараметр(
            ЭтотОбъект.КомпоновщикНастроек.ПользовательскиеНастройки, "ПериодОтчета");

    РезультатФункции.НачалоПериода = НачалоДня(ПараметрПериодОтчета.Значение.ДатаНачала);
    РезультатФункции.КонецПериода = КонецДня(ПараметрПериодОтчета.Значение.ДатаОкончания);

    БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
        ЭтотОбъект.КомпоновщикНастроек.Настройки, "НачалоПериода", РезультатФункции.НачалоПериода);

    БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
        ЭтотОбъект.КомпоновщикНастроек.Настройки, "КонецПериода", РезультатФункции.КонецПериода);

    // Установка границ
    РезультатФункции.НачалоПериода = Новый Граница(ПараметрПериодОтчета.Значение.ДатаНачала, ВидГраницы.Включая);
    РезультатФункции.КонецПериода = Новый Граница(ПараметрПериодОтчета.Значение.ДатаОкончания, ВидГраницы.Включая);

    БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
        ЭтотОбъект.КомпоновщикНастроек.Настройки, "НачалоПериодаГраница", РезультатФункции.НачалоПериода);

    БухгалтерскиеОтчетыКлиентСервер.УстановитьПараметр(
        ЭтотОбъект.КомпоновщикНастроек.Настройки, "КонецПериодаГраница", РезультатФункции.КонецПериода);

    Возврат РезультатФункции;
КонецФункции

#КонецОбласти // СлужебныеПроцедурыИФункции
// Гарант+ Килипенко 03.02.2025 [F00234067] Отчет Потребление по нормам --
