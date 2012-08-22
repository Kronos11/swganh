// This file is part of SWGANH which is released under the MIT license.
// See file LICENSE or go to http://swganh.com/LICENSE

#ifndef SWGANH_TERRAIN_SERVICE_BINDING_H_
#define SWGANH_TERRAIN_SERVICE_BINDING_H_

#ifndef WIN32
#include <Python.h>
#endif

#include "anh/logger.h"
#include "anh/python_shared_ptr.h"

#include <memory>
#include <boost/python.hpp>
#include <boost/python/overloads.hpp>

#include "swganh/terrain/terrain_service_interface.h"

using namespace swganh::terrain;
using namespace boost::python;

boost::python::tuple GetHeight(uint32_t scene_id, float x, float z, bool raw=false)
{
	return boost::python::make_tuple(scene_id, x, z, raw);
}
BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(GetHeightOverload, GetHeight, 3, 4);

boost::python::tuple GetWaterHeight(uint32_t scene_id, float x, float z, bool raw=false)
{
	return boost::python::make_tuple(scene_id, x, z, raw);
}
BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(GetWaterHeightOverload, GetWaterHeight, 3, 4);

boost::python::tuple IsWater(uint32_t scene_id, float x, float z, bool raw=false)
{
	return boost::python::make_tuple(scene_id, x, z, raw);
}
BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(IsWaterOverload, IsWater, 3, 4);

void exportTerrainService()
{
	class_<TerrainServiceInterface, std::shared_ptr<TerrainServiceInterface>, boost::noncopyable>("TerrainService", "The terrain service allows fetching of terrain height and water at x z coordinates.", no_init)
		.def("GetHeight", &TerrainServiceInterface::GetHeight, GetHeightOverload(args("scene_id", "x", "z", "raw"), "Returns the height of a particular x, z coordinate"))
		.def("GetWaterHeight", &TerrainServiceInterface::GetWaterHeight, GetWaterHeightOverload(args("scene_id", "x", "z", "raw"), "Returns the water height at a particular x, z coordinate. This is probably not necessary for external code."))
		.def("IsWater", &TerrainServiceInterface::IsWater, IsWaterOverload(args("scene_id", "x", "z", "raw"), "Returns true iff the x, z is water."));
}

#endif //SWGANH_TERRAIN_SERVICE_BINDING_H_