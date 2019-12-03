<?php
// Testing installated extensions

$all = get_loaded_extensions();
$search_this = [
  'gd',
  'pdo_mysql',
  'mysqli',
  'mcrypt',
  'intl',
  'gd',
  'exif',
  'bcmath',
  'SimpleXML',
  'zlib',
  'PDO',
  'bz2',
  'iconv'
];

$diff = array_diff($search_this, $all);
$containsAllValues = !$diff;

if (!$containsAllValues) {
  echo "\n\nExtensions test failed\n\n";
  echo "Missing extensions: \n\n";
  print_r($diff);
  echo "\n\n";
  exit(1);
}
