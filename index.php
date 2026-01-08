<?php 
    $server = "localhost";
    $username = "rgamosa";
    $password = "z1BMhd5F-9G*WSv";
    $database = "rgamosa_events";

    $connection = mysqli_connect($server, $username, $password, $database);
    if(!$connection){
        die('Could not connect '.mysqli_connect_error());
    }

    // get filter values
    $price_type = $_GET['price_type'] ?? '';
    $startdate = $_GET['startdate'] ?? '';
    $enddate = $_GET['enddate'] ?? '';
    $reservation = $_GET['reservation'] ?? '';
    $tod = $_GET['tod'] ?? '';

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Out and About - Ottawa | oaa.com</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div id="stickytop">
        <header>
            <h1>Out and About</h1>
            <p>A guide to your local <span>out and about</span> activities</p>
            <p id="city">City: Ottawa, ON</p>
        </header>
        <nav>
            <form action="index.php" method="GET">

                <label for="price_type">Fee Type:</label>
                <select name="price_type" id="price_type">
                    <option value="" <?php if ($price_type == '') echo 'selected'; ?>>All</option>
                    <option value="free" <?php if ($price_type == 'free') echo 'selected'; ?>>Free</option>
                    <option value="donation" <?php if ($price_type == 'donation') echo 'selected'; ?>>Donation</option>
                    <option value="fixed" <?php if ($price_type == 'fixed') echo 'selected'; ?>>Fixed</option>
                    <option value="range" <?php if ($price_type == 'range') echo 'selected'; ?>>Range</option>
                </select>

                <label for="startdate">Start Date:</label>
                <input type="date" id="startdate" name="startdate" min="2026-07-01" max="2026-08-31" value="2026-07-01">
                <label for="enddate">End Date:</label>
                <input type="date" id="enddate" name="enddate" min="2026-07-01" max="2026-08-31" value="2026-08-31">

                <label for="reservation">Reservation:</label>
                <select name="reservation" id="reservation">
                    <option value="" <?php if ($reservation == '') echo 'selected'; ?>>All</option>
                    <option value="1" <?php if ($reservation == '1') echo 'selected'; ?>>Required</option>
                    <option value="0" <?php if ($reservation == '0') echo 'selected'; ?>>Not Required</option>
                </select>

                <label for="tod">Time of Day:</label>
                <select name="tod" id="tod">
                    <option value="" <?php if ($tod == '') echo 'selected'; ?>>All</option>
                    <option value="day" <?php if ($tod == 'day') echo 'selected'; ?>>Daytime</option>
                    <option value="night" <?php if ($tod == 'night') echo 'selected'; ?>>Nighttime</option>
                </select>

                <div id="button">
                    <a href="index.php">Clear Filters</a>
                    <button type="submit">Filter Events</button>
                </div>
            </form>
        </nav>
    </div>
    <main>
        <?php
        // base query
        $query = "SELECT * FROM events WHERE 1";

        // add price type filter
        if (!empty($price_type)) {
            $query .= " AND price_type = '" . mysqli_real_escape_string($connection,$price_type) . "'";
        } 
        
        // add start/end date filter
        if (!empty($startdate) && !empty($enddate)) {
            $query .= " AND date BETWEEN '" . mysqli_real_escape_string($connection,$startdate) . "' AND '" . mysqli_real_escape_string($connection,$enddate) . "'";
        } elseif (!empty($startdate)) {
            $query .= " AND date >= '" . mysqli_real_escape_string($connection,$startdate) . "'";
        } elseif (!empty($enddate)) {
            $query .= " AND date <= '" . mysqli_real_escape_string($connection,$enddate) . "'";
        }

        if ($reservation !== '') {
            $query .= " AND require_reservation = " . (int)$reservation;
        }
        
        // add time of day filter
        if (!empty($tod)) {
            if ($tod === 'day') {
                $query .= " AND TIME(time_start) BETWEEN '06:00:00' AND '18:00:00'";
            } elseif ($tod === 'night') {
                $query .= " AND (TIME(time_start) >= '18:00:00' OR TIME(time_start) < '06:00:00')";
            }
        }

        
        
        $sql = mysqli_query($connection , $query);

        if (mysqli_num_rows($sql) == 0) {
            echo "<p id='zeroevents'>Sorry! There are no available events.</p>";
        } 
        
        while ($event = mysqli_fetch_assoc($sql))
        { 

        ?>
       
        <article>
            <!--image-->
            <img src="images/<?php echo $event['image']; ?>" alt="<?php echo $event['alt']; ?>" width="640" height="962">
            
            <!--name-->
            <h2><?php echo $event['name']; ?></h2>

            <!--fee-->
            <?php if ($event['price_type'] == "free"){
                        echo "<p>Free</p>";
                        } elseif ($event['price_type'] == "donation") {
                        echo "<p>Donation</p>";
                        } elseif ($event['price_type'] == "fixed") {
                        echo "<p>$" . number_format($event['price_min'], 2) . "</p>";
                        } elseif ($event['price_type'] == "range") {
                            echo "<p>$" . number_format($event['price_min'], 2) . " - $" . number_format($event['price_max'], 2) . "</p>";
                        }
            ?>
            <!-- reservation -->
            <span class="reqres">
                <?php if ($event['require_reservation'] == "1") {
                                echo "Requires online reservation";
                            } else {
                                echo "No reservations required"; 
                            }
                ?>
            </span>
            <br>

            <!-- time -->     
            <?php 
            $timestart = $event['time_start'];
            $timeend = $event['time_end'];

            if ($timestart && $timeend) {
                $format_time = date("g:i A", strtotime($timestart)) . " - " . date("g:i A", strtotime($timeend));
            } elseif ($timestart) {
                $format_time = date("g:i A", strtotime($timestart));
            } else {
                $format_time = "";
            }
            
            echo $format_time;
            ?>
            <br>
            <!-- date -->
            <?php 
            $date = $event['date'];
            $format_date = date("l, F j, Y", strtotime($date));

            echo $format_date;
            
            ?>
            <br>
            <!-- location -->
            <?php
            $locid = $event['location'];
            $locquery = "SELECT location.name FROM events JOIN location ON location.id = events.location WHERE location.id = $locid";
            $locsql = mysqli_query($connection , $locquery);

            if($loc = mysqli_fetch_assoc($locsql)) {
                echo "<p> @ {$loc['name']} </p>";
            }
            ?>

            <!-- description -->
            <p id="des"><?php echo $event['description']; ?></p>

            <!-- tags -->
            <?php
            $eventid = $event['id'];
            $tagquery = "SELECT tags.name FROM events JOIN eventstags ON events.id = eventstags.events_id JOIN tags ON tags.id = eventstags.tags_id WHERE eventstags.events_id=$eventid";
            $tagsql = mysqli_query($connection , $tagquery);

            if(mysqli_num_rows($tagsql)>0){
                echo "<div class ='events-tags'>";
                
                while($tagrow=mysqli_fetch_assoc($tagsql)){
                    echo "<span class='tag'>" . $tagrow['name'] . "</span>";
                }
                
                echo "</div>";
            }           
            ?>
        </article>

        <?php
            }
        ?>

    </main>

    <?php 
        mysqli_close($connection);
    ?>
    
    <footer>
        <p>Enjoy and have lots of fun!</p>
    </footer>
</body>
</html>