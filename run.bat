goto start

<?php
$movieName = "Star Trek - Voyager";
$beforeSeasonString = ".s";
$seasonEpisodeSeparator = ".e";
$allowedExtensions = array ('avi', 'mov', 'mp4', 'flv', 'mkv', 'txt');

$handle = opendir(getcwd());
while (false !== ($entry = readdir($handle))) {
  if ($entry != "." && $entry != "..") {
    $path = pathinfo($entry);
    if (in_array($path['extension'], $allowedExtensions)) {
      $name = $movieName.' - ';
      preg_match('/'.$beforeSeasonString.'\d{1,2}'.$seasonEpisodeSeparator.'\d{1,2}/i', $path['filename'], $matches);
      $num = $matches[0];
      $num = substr($num, strlen($beforeSeasonString));
      if ($num[0] != '0' && !ctype_digit($num[1])) {
        $num = '0'.$num;
      }
      while (ctype_digit($num[0])) {
        $name .= $num[0];
        $num = substr($num, 1);
      }
      $num = substr($num, strlen($seasonEpisodeSeparator));
      $name .= 'x';
      while (ctype_digit($num[0]) || strlen($num)) {
          $name .= $num[0];
          $num = substr($num, 1);
      }
      $name .= '.'.$path['extension'];
      if (!file_exists($name)) {
        rename($entry, $name);
      }
      echo "\"$entry\" -> \"$name\"\n";
    }
  }
}
closedir($handle);

/* nie usuwać tej sekcji!
:start
php run.bat

@REM */