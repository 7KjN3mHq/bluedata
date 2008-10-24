<?php
$year  = array_key_exists('year' , $_GET) ? intval($_GET['year'])     : date('Y');
$month = array_key_exists('month', $_GET) ? intval($_GET['month']) : date('m');
$day   = array_key_exists('day'  , $_GET) ? intval($_GET['day'])      : date('d');

$url = '&amp;databasebreak=day&amp;year=' . $year . '&amp;month=' . $month . '&amp;day=' . $day;
?> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN">
<html lang='cn'>
<head>
<meta name="robots" content="noindex,nofollow">
<meta http-equiv="content-type" content="text/html; charset=gbk">
<title>Statistics</title>
</head>

<frameset cols="240,*">
<frame name="mainleft" src="/cgi-bin/awstats.pl?framename=mainleft<?php echo $url; ?>" noresize="noresize" frameborder="0" />
<frame name="mainright" src="/cgi-bin/awstats.pl?framename=mainright<?php echo $url; ?>" noresize="noresize" scrolling="yes" frameborder="0" />
<noframes><body>Your browser does not support frames.<br />
You must set AWStats UseFramesWhenCGI parameter to 0
to see your reports.<br />
</body></noframes>
</frameset>

</html>