<?php
$host = getenv('MARIADB_HOST');
$dbname = getenv('MARIADB_DATABASE');
$user = getenv('MARIADB_USER');
$password = getenv('MARIADB_PASSWORD');

$conn = mysqli_connect($host, $user, $password, $dbname);

if (!$conn) {
    echo "❌ Connexion échouée : " . mysqli_connect_error() . PHP_EOL;
    exit(1);
}

echo "✅ Connexion réussie à la base de données '$dbname' sur '$host'." . PHP_EOL;

mysqli_close($conn);
?>
