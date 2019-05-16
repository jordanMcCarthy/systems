BEGIN{
    # table Header
    printf("%-7s %4s %18s %12s \n", "Name", "Flight", "Seats", "Total Cost")
}

{   
    # grabs customer name
    if($1 == "CUST"){
        name = $NF
    }
    # grabs flight, seat, total, and overall total for each customer.
    # prints reservation info for each customer. also creates the 
    # associative array to track how many seats for each flight
    if($1 == "RESERVE"){
        
        if ($2 in flights)
            flights[$2] += $3;
        else 
            flights[$2] = $3;

        flight = $2
        seats = $3
        total= $3 * $4
        runningTotal += total
        printf("%-7s %4s %10s %12s \n", name, flight, seats, total)
    }
    # prints our the overall total spent on reservation for each
    # customer and resets runningTotal variable to 0 for next
    # customer
    if($1 == "ENDCUST"){
        printf("%-7s %4s %20s %8s \n\n", "","", "Total", runningTotal)
        runningTotal = 0
    }
}
END{
    # table header for amount of seats for each flight and 
    # prints out the associative array with the corresponding
    # information
    printf("%-10s %2s\n", "Flight", "Seats Requested")
    for (key in flights)
        print key, flights[key]

}
