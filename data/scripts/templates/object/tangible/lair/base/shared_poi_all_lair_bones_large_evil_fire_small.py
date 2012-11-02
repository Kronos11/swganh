#### NOTICE: THIS FILE IS AUTOGENERATED
#### MODIFICATIONS MAY BE LOST IF DONE IMPROPERLY
#### PLEASE SEE THE ONLINE DOCUMENTATION FOR EXAMPLES

from swgpy.object import *
from . import base

class Template(BaseTemplate):
	name = "object/tangible/lair/base/shared_poi_all_lair_bones_large_evil_fire_small.iff"
	is_prototype = False
	
	def create(self, kernel, params):
		result = Tangible()		
		init(kernel, params, result)
		
		return result

def init(kernel, params, result):
	try:
		base.init(kernel, params, result)
	except AttributeError:
		print('base.init doesnt exist')
	result.template = "object/tangible/lair/base/shared_poi_all_lair_bones_large_evil_fire_small.iff"
	result.attribute_template_id = -1
	result.stfName("lair_n","bones")	
	
	#### BEGIN MODIFICATIONS ####		
	####  END MODIFICATIONS  ####
		
def loadTemplates(addTemplate):
	addTemplate(Template())