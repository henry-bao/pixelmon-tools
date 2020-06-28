# install.packages("datetime")
# library("datetime")

# Time calc
irl_mc <- function(hour, min, sec, mc_hr, mc_min) {
  ##convert irl min/sec to mc hour/min
  final_mc_hour <- min * 1.2 + sum(hour * 60 * 1.2)
  final_mc_min <- sec * 1.2
  
  
  ##test if converted hour has digits, if yes then convert the digits into
  ##minutes and get rid of the digits
  if (is.integer(final_mc_hour) == FALSE) {
    extra_mc_hour <- sum(final_mc_hour - as.integer(final_mc_hour))
    final_mc_hour <- as.integer(final_mc_hour)
    get_extra_min <- extra_mc_hour * 60
    final_mc_min <- final_mc_min + get_extra_min
    ##else keep final converted hour
  } else {
    final_mc_hour
  }
  
  
  ##if the minute that's added to the extra time from converting hours is
  ##bigger than 60 then subtract 60 from it and add 1 hour to final hour count
  if (final_mc_min > 60) {
    final_mc_min <- final_mc_min - 60
    final_mc_hour <- final_mc_hour + 1
    ##if the minute that's added to the extra time from converting hours is
    ##equal than 60 then set minute to 0 and add 1 hour to final hour count
  } else if (final_mc_min == 60) {
    final_mc_min <- 0
    final_mc_hour <- final_mc_hour + 1
    ##else keep final min count
  } else {
    final_mc_min
  }
  
  
  ##if final hour is bigger than 24 then divide 24 or the multiplier of 24
  if (is.integer(sum(final_mc_hour / 24)) == FALSE && final_mc_hour > 24) {
    multiplier <- as.integer(final_mc_hour / 24)
    final_mc_hour <- final_mc_hour - sum(24 * multiplier)
    ##if final hour is 24 or the multiplier of 24 then final hour is 0
  } else if (final_mc_hour >= 24) {
    final_mc_hour <- 0
  } else {
    final_mc_hour
  }
  
  
  ##add next spawn min and hour to current min and hour
  next_hr <- final_mc_hour + mc_hr
  next_min <- final_mc_min + mc_min
  
  
  ##if the minute is bigger than 60 then subtract 60 from it and add 1 hour to
  ##next spawn hour count
  if (next_min > 60) {
    next_min <- next_min - 60
    next_hr <- next_hr + 1
    ##if the minute is #equal than 60 then set minute to 0 and add 1 hour to
    ##next spawn hour count
  } else if (next_min == 60) {
    next_min <- 0
    next_hr <- next_hr + 1
    ##else keep next spawn min count
  } else {
    next_min
  }
  
  
  ##if final hour is bigger than 24 subtract 24
  if (next_hr >= 24) {
    next_hr <- next_hr - 24
    ##else keep next spawn hour count
  } else {
    next_hr
  }
  
  
  ##divide final min by 60 to get hour count and add it to final hour
  check_min <- next_min / 60
  check_time <- check_min + next_hr
  
  ##based on the result above determine which time period the calculated
  ##spawn time is in
  time1 <- if (check_time >= 4 + 30 / 60 &&
               check_time <= 5 + 59 / 60) {
                paste("Dawn, Morning")
              } else if (check_time >= 6 &&
                         check_time <= 6 + 18 / 60) {
                paste("Dawn, Morning, Day")
              } else if (check_time >= 6 + 19 / 60 &&
                         check_time <= 12) {
                paste("Day, Morning")
              } else if (check_time >= 12 + 1 / 60 &&
                         check_time <= 18) {
                paste("Day, Afternoon")
              } else if (check_time >= 18 + 1 / 60 &&
                         check_time <= 19 + 21 / 60) {
                paste("Dusk")
              } else if (check_time >= 19 + 22 / 60 &&
                         check_time <= 19 + 48 / 60) {
                paste("Dusk, Night")
              } else if (check_time >= 19 + 44 / 60 &&
                         check_time <= 23 + 59/60) {
                paste("Night")
              } else if (check_time >= 0 &&
                         check_time <= 4 + 29 / 60) {
                paste("Night")
              } else {
                paste("If you see this that means the Minecraft hour you entered
                      is larger than 23")
              }

  ##return calculated values
  return(paste("[", next_hr,":",
               round(next_min, digits = 0), "]", time1))
}
