﻿#Область ПрограммныйИнтерфейс

// Возвращаемое значение:
//  - Структура
//      * Ссылка - СправочникСсылка.КВП_Услуги
//      * Код - Строка
//      * Наименование - Строка
Функция ПолучитьНоменклатурнуюГруппуНегативногоВоздействия() Экспорт
    Возврат ГП_РаботаСНоменклатурами.ПолучитьНоменклатурнуюГруппуНегативноеВоздействиеНаЦСВ();
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныйПрограммныйИнтерфейс

#Область СКДРасчеты

// Параметры:
//  ИмяКолонкиКоличества - Строка
// Возвращаемое значение:
//  - Строка
Функция ПолучитьТекстЗапросаКоличестваЖильцовПоЛицевымСчетам(Знач ИмяКолонкиКоличества) Экспорт
    ТекстЗапроса =
        "ВЫБРАТЬ РАЗРЕШЕННЫЕ
        |   ЛицевойСчет,
        |   __КоличествоЖильцов__
        |ПОМЕСТИТЬ ВТ_ТаблицаДанных
        |ИЗ
        |   &ТаблицаДанных КАК ТаблицаДанных
        |;
        |
        |ВЫБРАТЬ РАЗРЕШЕННЫЕ
        |   ЛицевойСчет,
        |   МАКСИМУМ(__КоличествоЖильцов__)
        |ПОМЕСТИТЬ ВТ_Результат_Подготовка
        |ИЗ
        |   ВТ_ТаблицаДанных КАК ВТ_ТаблицаДанных
        |СГРУППИРОВАТЬ ПО
        |   ЛицевойСчет
        |
        |;
        |ВЫБРАТЬ РАЗРЕШЕННЫЕ
        |   СУММА(__КоличествоЖильцов__) КАК Сумма
        |ИЗ
        |   ВТ_Результат_Подготовка КАК ВТ_Результат_Подготовка
        |";

    ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "__КоличествоЖильцов__", ИмяКолонкиКоличества);
    Возврат ТекстЗапроса;
КонецФункции

// Параметры:
//  ИмяКолонкиКоличества - Строка
// Возвращаемое значение:
//  - Строка
Функция ПолучитьТекстЗапросаСуммыНормативаПоЛицевымСчетам(Знач ИмяКолонкиНорматива) Экспорт
    ТекстЗапроса =
        "ВЫБРАТЬ РАЗРЕШЕННЫЕ
        |   ЛицевойСчет,
        |   Услуга,
        |   __ИмяКолонкиНорматива__
        |ПОМЕСТИТЬ ВТ_ТаблицаДанных
        |ИЗ
        |   &ТаблицаДанных КАК ТаблицаДанных
        |;
        |
        |ВЫБРАТЬ РАЗРЕШЕННЫЕ
        |   ЛицевойСчет,
        |   Услуга,
        |   МАКСИМУМ(__ИмяКолонкиНорматива__)
        |ПОМЕСТИТЬ ВТ_Результат_Подготовка
        |ИЗ
        |   ВТ_ТаблицаДанных КАК ВТ_ТаблицаДанных
        |СГРУППИРОВАТЬ ПО
        |   ЛицевойСчет,
        |   Услуга
        |
        |;
        |ВЫБРАТЬ РАЗРЕШЕННЫЕ
        |   СУММА(__ИмяКолонкиНорматива__) КАК Сумма
        |ИЗ
        |   ВТ_Результат_Подготовка КАК ВТ_Результат_Подготовка
        |";

    ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "__ИмяКолонкиНорматива__", ИмяКолонкиНорматива);
    Возврат ТекстЗапроса;
КонецФункции

#КонецОбласти // СКДРасчеты

#КонецОбласти // СлужебныйПрограммныйИнтерфейс