#### NOTICE: THIS FILE IS AUTOGENERATED
#### MODIFICATIONS MAY BE LOST IF DONE IMPROPERLY
#### PLEASE SEE THE ONLINE DOCUMENTATION FOR EXAMPLES

from swgpy.object import *
from . import base

class Template(BaseTemplate):
	name = "object/tangible/component/vehicle/base/shared_base_veh_weapon.iff"
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
	result.template = "object/tangible/component/vehicle/base/shared_base_veh_weapon.iff"
	result.attribute_template_id = -1
	result.stfName("component_n","base_component")	
	
	#### BEGIN MODIFICATIONS ####		
	####  END MODIFICATIONS  ####
		
def loadTemplates(addTemplate):
	addTemplate(Template())