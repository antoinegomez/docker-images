<?php

echo "\n\n------------------------ TESTS ------------------------\n\n";

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
  echo "\n\nExtensions test: FAILED\n\n";
  echo "Missing extensions: \n\n";
  print_r($diff);
  echo "\n\n";
  exit(1);
} else {
  echo "Extensions test: OK!\n\n";
}

echo "Max input vars: ";
echo ini_get('max_input_vars');

echo "\nEnv: " . @$_SERVER['MAX_INPUT_VARS'];

if (@$_SERVER['MAX_INPUT_VARS'] != ini_get('max_input_vars')) {
  echo "\n\nmax input vars test FAILED\n\n";
  exit(1);
}

echo "\n\n";
echo "-------------------------------------------------------------\n\n\n";
