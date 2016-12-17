# Copyright © 2016 Alessandro Menti
# This Makefile is free; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# This Makefile is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this Makefile; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA 02111-1307 USA, or visit <http://www.gnu.org/
# licenses/>.

# Adjust the following paths as necessary.
RM                    := rm
MKDIR                 := mkdir
TOUCH                 := touch
TERRAGEAR_ROOT        := /usr

# Latitudes and longitudes for the tile.
MINLAT      := 45
MAXLAT      := 46
MINLON      := 10
MAXLON      := 11
SRTMTILE    := N45E010

# Specify if we're using SRTM-1 or SRTM-3 data.
SRTMVERSION := 1

# Do not edit anything below this line.
# ----------------------------------------------------------------------------
# Create the build directories
output:
	$(MKDIR) output

work:
	$(MKDIR) work

# Chop and fit the elevation data
work/SRTM-$(SRTMVERSION): work data/SRTM-$(SRTMVERSION)/$(SRTMTILE).hgt
	mkdir work/SRTM-$(SRTMVERSION)
	$(TERRAGEAR_ROOT)/bin/gdalchop work/SRTM-$(SRTMVERSION) data/SRTM-$(SRTMVERSION)/$(SRTMTILE).hgt
	$(TERRAGEAR_ROOT)/bin/terrafit work/SRTM-$(SRTMVERSION)

# Generate the airports
work/AirportArea: work data/airports/apt.dat
	$(TERRAGEAR_ROOT)/bin/genapts850 --input=data/airports/apt.dat --work=work --dem-path=SRTM-$(SRTMVERSION)

# Run ogr-decode on all landclasses
# FIXME: simplify + check for updates to all classes
work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Airport "work/Airport" "data/clc06v16_airport"

work/BarrenCover: work data/clc06v16_barrencover
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type BarrenCover "work/BarrenCover" "data/clc06v16_barrencover"

work/ComplexCrop: work data/clc06v16_complexcrop
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type ComplexCrop "work/ComplexCrop" "data/clc06v16_complexcrop"

work/Construction: work data/clc06v16_construction
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Construction "work/Construction" "data/clc06v16_construction"

work/CropGrass: work data/clc06v16_cropgrass
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type CropGrass "work/CropGrass" "data/clc06v16_cropgrass"

work/DeciduousForest: work data/clc06v16_deciduousforest
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type DeciduousForest "work/DeciduousForest" "data/clc06v16_deciduousforest"

work/DryCrop: work data/clc06v16_drycrop
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type DryCrop "work/DryCrop" "data/clc06v16_drycrop"

work/EvergreenForest: work data/clc06v16_evergreenforest
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type EvergreenForest "work/EvergreenForest" "data/clc06v16_evergreenforest"

work/GolfCourse: work data/clc06v16_golfcourse
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type GolfCourse "work/GolfCourse" "data/clc06v16_golfcourse"

work/Grassland: work data/clc06v16_grassland
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Grassland "work/Grassland" "data/clc06v16_grassland"

work/Greenspace: work data/clc06v16_greenspace
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Greenspace "work/Greenspace" "data/clc06v16_greenspace"

work/Heath: work data/clc06v16_heath
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Heath "work/Heath" "data/clc06v16_heath"

work/Industrial: work data/clc06v16_industrial
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Industrial "work/Industrial" "data/clc06v16_industrial"

work/Lake: work data/clc06v16_lake
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Lake "work/Lake" "data/clc06v16_lake"

work/Marsh: work data/clc06v16_marsh
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Marsh "work/Marsh" "data/clc06v16_marsh"

work/MixedCrop: work data/clc06v16_mixedcrop
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type MixedCrop "work/MixedCrop" "data/clc06v16_mixedcrop"

work/MixedForest: work data/clc06v16_mixedforest
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type MixedForest "work/MixedForest" "data/clc06v16_mixedforest"

work/NaturalCrop: work data/clc06v16_naturalcrop
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type NaturalCrop "work/NaturalCrop" "data/clc06v16_naturalcrop"

work/Olives: work data/clc06v16_olives
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Olives "work/Olives" "data/clc06v16_olives"

work/OpenMining: work data/clc06v16_openmining
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type OpenMining "work/OpenMining" "data/clc06v16_openmining"

work/Orchard: work data/clc06v16_orchard
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Orchard "work/Orchard" "data/clc06v16_orchard"

work/Rice: work data/clc06v16_rice
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Rice "work/Rice" "data/clc06v16_rice"

work/Rock: work data/clc06v16_rock
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Rock "work/Rock" "data/clc06v16_rock"

work/Sand: work data/clc06v16_sand
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Sand "work/Sand" "data/clc06v16_sand"

work/Scrub: work data/clc06v16_scrub
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Scrub "work/Scrub" "data/clc06v16_scrub"

work/Town: work data/clc06v16_town
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Town "work/Town" "data/clc06v16_town"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Transport "work/Transport" "data/clc06v16_transport"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Urban "work/Urban" "data/clc06v16_urban"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Vineyard "work/Vineyard" "data/clc06v16_vineyard"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Watercourse "work/Watercourse" "data/clc06v16_watercourse"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Canal "work/Canal" "data/osm_canal"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 4 --continue-on-errors --area-type Watercourse "work/Drain" "data/osm_drain"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Railroad "work/LightRail" "data/osm_light_rail"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Construction "work/Raceway" "data/osm_raceway"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 12 --continue-on-errors --area-type Railroad "work/Rail" "data/osm_rail"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type River "work/River" "data/osm_river"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Estuary "work/Riverbank" "data/osm_riverbank"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Stream "work/Stream" "data/osm_stream"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Railroad "work/Subway" "data/osm_subway"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 5 --continue-on-errors --area-type Railroad "work/Tram" "data/osm_tram"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 3 --continue-on-errors --area-type Road-Tertiary "work/Bridleway" "data/osm_bridleway"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 2 --continue-on-errors --area-type Road-Pedestrian "work/Cycleway" "data/osm_cycleway"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 2 --continue-on-errors --area-type Road-Pedestrian "work/Footway" "data/osm_footway"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 12 --continue-on-errors --area-type Road-Motorway "work/Motorway" "data/osm_motorway"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 2 --continue-on-errors --area-type Road-Pedestrian "work/Pedestrian" "data/osm_pedestrian"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 12 --continue-on-errors --area-type Road-Primary "work/RoadPrimary" "data/osm_primary"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Road-Secondary "work/RoadSecondary" "data/osm_secondary"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Road-Tertiary "work/RoadTertiary" "data/osm_tertiary"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 7 --continue-on-errors --area-type Road-Residential "work/RoadResidential" "data/osm_residential"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 7 --continue-on-errors --area-type Road-Service "work/RoadService" "data/osm_service"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 2 --continue-on-errors --area-type Road-Steps "work/Steps" "data/osm_steps"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 3 --continue-on-errors --area-type Road-Tertiary "work/Track" "data/osm_track"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 12 --continue-on-errors --area-type Road-Trunk "work/Trunk" "data/osm_trunk"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 7 --continue-on-errors --area-type Road-Unclassified "work/Unclassified" "data/osm_unclassified"

work/Airport: work data/clc06v16_airport
	$(TGROOT)/bin/ogr-decode --line-width 10 --continue-on-errors --area-type Default "work/Landmass" "data/v0_landmass"

# Construct the scenery
output: work
	$(TGROOT)/bin/tg-construct --output-dir=output --work-dir=work --min-lon=$(MINLON) --max-lon=$(MAXLON) --min-lat=$(MINLAT) --max-lat=$(MAXLAT) --threads Airport AirportArea AirportObj BarrenCover Bridleway Canal ComplexCrop Construction CropGrass Cycleway DeciduousForest Drain DryCrop EvergreenForest Footway GolfCourse Grassland Greenspace Heath Industrial Lake Landmass LightRail Marsh MixedCrop MixedForest Motorway NaturalCrop Olives OpenMining Orchard Pedestrian Raceway Rail Rice River Riverbank RoadPrimary RoadResidential RoadSecondary RoadService RoadTertiary Rock Sand Scrub SRTM-1 Steps Stream Subway Town Track Tram Transport Trunk Unclassified Urban Vineyard Watercourse

.PHONY: output work clean all
