/* Name, Minflt, Utime, Stime, threads, vsize, rss */
 { printf("%s %s %s %s %s %u %u\n", $2, $10, $14, $15, $20, $23 / 1024, $24 * 4); }
