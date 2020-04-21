/** @file example.c
 *  @brief An example usage of this timezone database mapping in an embedded system
 *
 *  @author Jacob Lambert
 */

#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>

#include "zones.h"

void print_local_time(const char *name) {
  time_t now;
  time(&now);
  struct tm timeinfo;
  char strftime_buf[64];
  
  const char * posix_str = posix_tz_db_get_posix_str(name);
  
  if (posix_str) {
    setenv("TZ", posix_str, 1);
    tzset();

    localtime_r(&now, &timeinfo);
    strftime(strftime_buf, sizeof(strftime_buf), "%c", &timeinfo);
    printf("The current date/time in %s is: %s\n", name, strftime_buf);
  } else {
    printf("%s is not a known timezone!\n", name);
  }
  
}

int main() {
  print_local_time("America/New_York");
  print_local_time("Asia/Shanghai");
  print_local_time("Europe/Lisbon");
  print_local_time("亚洲/武汉");
}
