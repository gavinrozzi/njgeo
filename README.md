
<!-- README.md is generated from README.Rmd. Please edit that file -->

# njgeo <a href='https://gavinrozzi.github.io/njgeo/'><img src='man/figures/logo.png' align="right" height="175" width="150" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/gavinrozzi/njgeo/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/gavinrozzi/njgeo/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Tools for geocoding addresses using the State of New Jersey’s official
geocoding service & accessing spatial data.

## Installation

You can install njgeo from CRAN using

``` r
install.packages("njgeo")
```

You can install the development version of njgeo from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("gavinrozzi/njgeo")
```

## Usage

### Geocoding

This package supports freely geocoding addresses in New Jersey. No API
keys are required and this does not depend on any commercial services.

## Find all matching address candidates for an address

``` r
geocode_address_candidates("33 Livingston Ave. New Brunswick, NJ")
#> njgeo: downloading data
#> Simple feature collection with 1 feature and 8 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: -74.44513 ymin: 40.49297 xmax: -74.44513 ymax: 40.49297
#> Geodetic CRS:  WGS 84
#>                                          address score location.x location.y
#> 1 33 Livingston Avenue, New Brunswick, NJ, 08901   100  -74.44513   40.49297
#>   extent.xmin extent.ymin extent.xmax extent.ymax                   geometry
#> 1   -74.44613    40.49197   -74.44413    40.49397 POINT (-74.44513 40.49297)
```

The geocoding output defaults to EPSG:4326 but another CRS can be
specified via arguments:

``` r
geocode_address_candidates("33 Livingston Ave. New Brunswick, NJ", crs = 3424)
#> njgeo: downloading data
#> Simple feature collection with 1 feature and 8 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 507385.6 ymin: 604489.2 xmax: 507385.6 ymax: 604489.2
#> Projected CRS: NAD83 / New Jersey (ftUS)
#>                                          address score location.x location.y
#> 1 33 Livingston Avenue, New Brunswick, NJ, 08901   100   507385.6   604489.2
#>   extent.xmin extent.ymin extent.xmax extent.ymax                  geometry
#> 1    507107.3    604124.7      507664    604853.6 POINT (507385.6 604489.2)
```

### Batch Geocoding

It is possible to batch geocode up to 1000 addresses at once using the
two batch geocoding functions provided by the package.

The `batch_geocode_addresses()` and `batch_geocode_sl()` functions can
batch geocode up to 1000 addresses at a time. The first function expects
multiple columns of data to geocode the address, while the **sl**
version requires an address in single column format.

### Reverse Geocoding

Provide a point to get matching addresses:

``` r
point <- st_point(c(-74.44513, 40.49297))

reverse_geocode(point)
#> njgeo: downloading data
#>                Address  Neighborhood          City Subregion Region Postal
#> 1 33 Livingston Avenue New Brunswick New Brunswick Middlesex     NJ  08901
#>   PostalExt CountryCode                                     Match_addr
#> 1      1900             33 Livingston Avenue, New Brunswick, NJ, 08901
#>         Loc_name
#> 1 NJ_Geocode_Mul
```

## Shape and boundary files

You can easily obtain spatial boundary data for use in projects via this
package. All objects are returned as an `{sf}` object and a coordinate
reference system can be specified via arguments to repoject the shape
into a different CRS.

### State

``` r
get_state_bounds()
#> njgeo: downloading data
#> Simple feature collection with 1 feature and 9 fields
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -75.56342 ymin: 38.85289 xmax: -73.89363 ymax: 41.35765
#> Geodetic CRS:  WGS 84
#>   OBJECTID       NAME           GNIS_NAME    GNIS   ACRES SQ_MILES SHAPE_Length
#> 1        1 New Jersey State of New Jersey 1779795 5549497 8671.089      2703088
#>     SHAPE_Area                               GLOBALID
#> 1 241735115122 {64BFC6D2-D0A8-418C-9E76-ADF18AA40F74}
#>                         geometry
#> 1 POLYGON ((-74.67081 41.3463...
```

### Counties

``` r
get_county_bounds()
#> njgeo: downloading data
#> Simple feature collection with 21 features and 24 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -75.55957 ymin: 38.92852 xmax: -73.90245 ymax: 41.35765
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>    OBJECTID                               GLOBALID     COUNTY      COUNTY_LABEL
#> 1        22 {82773E16-D911-409D-9684-ED69AF591A7B}   ATLANTIC   Atlantic County
#> 2        23 {08727489-7302-4C65-9A7E-E302A0305722}     BERGEN     Bergen County
#> 3        24 {838CB116-70DE-4BE2-864A-627AEAB5AEF1} BURLINGTON Burlington County
#> 4        25 {EA83A00A-6573-4E2B-AF36-0E91D73F264D}     CAMDEN     Camden County
#> 5        26 {B49347FF-4CCA-4B16-B4C4-1BBFC6FDD897}   CAPE MAY   Cape May County
#> 6        27 {6761F619-0390-46DC-B8AE-830BE0469DBD} CUMBERLAND Cumberland County
#> 7        28 {84679697-9EA2-4809-9EEE-EF97A030316F}      ESSEX      Essex County
#> 8        29 {1FCC09AD-739E-4CD4-97CC-A73B9649B471} GLOUCESTER Gloucester County
#> 9        30 {2F690E11-3D90-4F7D-A658-8CA971880B1F}     HUDSON     Hudson County
#> 10       31 {70EB7642-633E-461B-A911-0E80B4B9C67E}  HUNTERDON  Hunterdon County
#>     CO            GNIS_NAME   GNIS FIPSSTCO FIPSCO     ACRES SQ_MILES POP2020
#> 1  ATL   County of Atlantic 882270    34001      1 390813.84 610.6466  274534
#> 2  BER     County of Bergen 882271    34003      3 153489.66 239.8276  955732
#> 3  BUR County of Burlington 882272    34005      5 524901.24 820.1582  461860
#> 4  CAM     County of Camden 882273    34007      7 145597.91 227.4967  523485
#> 5  CAP   County of Cape May 882274    34009      9 183125.84 286.1341   95263
#> 6  CUM County of Cumberland 882275    34011     11 321149.04 501.7954  154152
#> 7  ESS      County of Essex 882276    34013     13  83034.53 129.7414  863728
#> 8  GLO County of Gloucester 882277    34015     15 215072.30 336.0505  302294
#> 9  HUD     County of Hudson 882278    34017     17  32982.27  51.5348  724854
#> 10 HUN  County of Hunterdon 882228    34019     19 279878.22 437.3097  128947
#>    POP2010 POP2000 POP1990 POP1980 POPDEN2020 POPDEN2010 POPDEN2000 POPDEN1990
#> 1   274549  252552  275372  204615        450        450        414        451
#> 2   905116  884118  829592  849843       3985       3774       3686       3459
#> 3   448734  423394  395066  362542        563        547        516        482
#> 4   513657  508932  532498  471650       2301       2258       2237       2341
#> 5    97265  102326   95089   82266        333        340        358        332
#> 6   156898  146438  138053  132866        307        313        292        275
#> 7   783969  793633  748281  850451       6657       6043       6117       5767
#> 8   288288  254673  230082  199917        900        858        758        685
#> 9   634266  608975  553099  556972      14065      12307      11817      10732
#> 10  128349  121989  107776   87361        295        293        279        246
#>    POPDEN1980       REGION SHAPE_Length SHAPE_Area
#> 1         335      COASTAL     2.054478 0.16559498
#> 2        3544 NORTHEASTERN     1.393879 0.06645191
#> 3         442     SOUTHERN     2.439422 0.22368243
#> 4        2073     SOUTHERN     1.553964 0.06197876
#> 5         288      COASTAL     1.589942 0.07723522
#> 6         265     SOUTHERN     2.213655 0.13586761
#> 7        6555 NORTHEASTERN     1.105311 0.03585682
#> 8         595     SOUTHERN     1.804883 0.09143512
#> 9       10808 NORTHEASTERN     1.225024 0.01423219
#> 10        200      CENTRAL     1.783708 0.12046630
#>                          geometry
#> 1  MULTIPOLYGON (((-74.67437 3...
#> 2  MULTIPOLYGON (((-73.90569 4...
#> 3  MULTIPOLYGON (((-74.69864 4...
#> 4  MULTIPOLYGON (((-75.03314 3...
#> 5  MULTIPOLYGON (((-74.85962 3...
#> 6  MULTIPOLYGON (((-75.06186 3...
#> 7  MULTIPOLYGON (((-74.32256 4...
#> 8  MULTIPOLYGON (((-75.12857 3...
#> 9  MULTIPOLYGON (((-74.16093 4...
#> 10 MULTIPOLYGON (((-74.86234 4...
```

### Municipalities

``` r
get_muni_bounds()
#> njgeo: downloading data
#> Simple feature collection with 564 features and 26 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: -75.55957 ymin: 38.92852 xmax: -73.90245 ymax: 41.35765
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>    OBJECTID                 MUN   COUNTY              MUN_LABEL MUN_TYPE
#> 1         1 CAPE MAY POINT BORO CAPE MAY Cape May Point Borough  Borough
#> 2         2  WEST CAPE MAY BORO CAPE MAY  West Cape May Borough  Borough
#> 3         3       CAPE MAY CITY CAPE MAY          Cape May City     City
#> 4         4 WILDWOOD CREST BORO CAPE MAY Wildwood Crest Borough  Borough
#> 5         5  WEST WILDWOOD BORO CAPE MAY  West Wildwood Borough  Borough
#> 6         6 NORTH WILDWOOD CITY CAPE MAY    North Wildwood City     City
#> 7         7           LOWER TWP CAPE MAY         Lower Township Township
#> 8         8   STONE HARBOR BORO CAPE MAY   Stone Harbor Borough  Borough
#> 9         9         AVALON BORO CAPE MAY         Avalon Borough  Borough
#> 10       10          MIDDLE TWP CAPE MAY        Middle Township Township
#>                      NAME                 GNIS_NAME   GNIS  SSN MUN_CODE
#> 1  Cape May Point Borough Borough of Cape May Point 885179 0503     0503
#> 2   West Cape May Borough  Borough of West Cape May 885435 0512     0512
#> 3                Cape May          City of Cape May 885178 0502     0502
#> 4  Wildwood Crest Borough Borough of Wildwood Crest 885445 0515     0515
#> 5   West Wildwood Borough  Borough of West Wildwood 885441 0513     0513
#> 6          North Wildwood    City of North Wildwood 885328 0507     0507
#> 7          Lower Township         Township of Lower 882044 0505     0505
#> 8    Stone Harbor Borough   Borough of Stone Harbor 885410 0510     0510
#> 9          Avalon Borough         Borough of Avalon 885146 0501     0501
#> 10        Middle Township        Township of Middle 882045 0506     0506
#>    CENSUS2020 CENSUS2010      ACRES   SQ_MILES POP2020 POP2010 POP2000 POP1990
#> 1  3400910330       <NA>   192.0504  0.3000787     305     291     241     248
#> 2  3400978530       <NA>   756.5358  1.1820872    1010    1024    1095    1026
#> 3  3400910270       <NA>  1844.8239  2.8825373    2768    3607    4034    4668
#> 4  3400981200       <NA>   947.7230  1.4808172    3101    3270    3980    3631
#> 5  3400980210       <NA>   232.8404  0.3638131     540     603     448     453
#> 6  3400953490       <NA>  1593.6177  2.4900277    3621    4041    4935    5017
#> 7  3400941610       <NA> 19851.6166 31.0181509   22057   22866   22945   20820
#> 8  3400971010       <NA>  1479.9483  2.3124192     796     866    1128    1025
#> 9  3400902320       <NA>  3179.4341  4.9678658    1243    1334    2143    1809
#> 10 3400945810       <NA> 52934.7845 82.7106008   20380   18911   16405   14771
#>    POP1980 POPDEN2020 POPDEN2010 POPDEN2000 POPDEN1990 POPDEN1980 SHAPE_Length
#> 1      255       1016        970        803        826        850   0.04154698
#> 2     1091        854        866        926        868        923   0.08769263
#> 3     4853        960       1251       1399       1619       1684   0.20318471
#> 4     4149       2094       2208       2688       2452       2802   0.10132480
#> 5      360       1484       1657       1231       1245        990   0.05201539
#> 6     4714       1454       1623       1982       2015       1893   0.14039854
#> 7    17105        711        737        740        671        551   0.52199887
#> 8     1187        344        374        488        443        513   0.13930193
#> 9     2162        250        269        431        364        435   0.22707767
#> 10   11373        246        229        198        179        138   0.81069461
#>      SHAPE_Area                       geometry
#> 1  8.075899e-05 MULTIPOLYGON (((-74.95983 3...
#> 2  3.181544e-04 MULTIPOLYGON (((-74.92585 3...
#> 3  7.758056e-04 MULTIPOLYGON (((-74.8765 38...
#> 4  3.987271e-04 MULTIPOLYGON (((-74.83331 3...
#> 5  9.800047e-05 MULTIPOLYGON (((-74.8189 39...
#> 6  6.707966e-04 MULTIPOLYGON (((-74.7797 39...
#> 7  8.352893e-03 MULTIPOLYGON (((-74.934 39....
#> 8  6.232645e-04 MULTIPOLYGON (((-74.75414 3...
#> 9  1.339875e-03 MULTIPOLYGON (((-74.7138 39...
#> 10 2.230602e-02 MULTIPOLYGON (((-74.7174 39...
```
