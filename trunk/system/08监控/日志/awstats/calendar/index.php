<?php
include('calendar.php');

class MyCalendar extends Calendar
{
       function getDateLink($day, $month, $year)
       {
        $link = '';

           if(mktime(0, 0, 0, $month, $day, $year) < mktime(0, 0, 0, date('m'), date('d'), date('Y')))
           { 
            $link = 'awstats.php?year=' . $year . '&amp;month=' . $month . '&amp;day=' . $day;
           }

           return $link;
       }

       function getCalendarLink($month, $year)
       {
           return '?month=' . $month . '&year=' . $year;
       }
}

$cal = new MyCalendar();

$chineseMonths = array(
    "一月",
    "二月",
    "三月",
    "四月",
    "五月",
    "六月",
    "七月",
    "八月",
    "九月",
    "十月",
    "十一月",
    "十二月"
);

$chineseDays = array ("日", "一", "二", "三", "四", "五", "六");

$cal->setMonthNames($chineseMonths);
$cal->setDayNames($chineseDays);

$cal->setStartDay(1);

$month = array_key_exists('month', $_GET) ? intval($_GET['month']) : date('m');
$year  = array_key_exists('year' , $_GET) ? intval($_GET['year'])     : date('Y');

$content = $cal->getMonthView($month, $year);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>AWStats</title>
<style>
.calendarHeader {
font-weight: bolder;
color: #CC0000;
background-color: #FFFFCC;
}

.calendarToday {
background-color: #FFFFFF;
}

.calendar {
background-color: #FFFFCC;
}
</style>
</head>

<body>
<?php echo $content; ?>
</body>
</html>