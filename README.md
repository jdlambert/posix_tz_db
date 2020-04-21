An embeddable mapping between [IANA Time Zone Database](https://www.iana.org/time-zones) names
(like "America/New_York" and "China/Shanghai") and their equivalent [POSIX `"TZ"` rule descriptions](https://www.freebsd.org/cgi/man.cgi?query=tzset)
(like "EST5EDT,M3.2.0,M11.1." and "CST-8").

In this way, more user-friendly names can be used in a timezone-setting API, and
timezone rules can be easily updated with a firmware upgrade.

### Usage

See `example/example.c` for an embedded use case.

Provide user-facing clients with `zones.json` to have a shared timezone vocabulary with the embedded library.

### Build

Since the build is heavily environment-dependant, the Dockerfile provides a consistent build environment — latest Arch Linux. When the IANA timezone database updates (a few times a year, usually: see the latest version [here](https://www.iana.org/time-zones) and compare to the release name/date), just run `make` in the root directory to rebuild all the "data" build artifacts (`zones.c` etc.). These data build artifacts can be checked in to source control since they change so infrequently.

If the IANA timezone database hasn't changed, you can just build `zones.o`, which isn't as sensitive to the build environment.
