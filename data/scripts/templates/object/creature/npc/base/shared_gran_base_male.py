#### NOTICE: THIS FILE IS AUTOGENERATED
#### MODIFICATIONS MAY BE LOST IF DONE IMPROPERLY
#### PLEASE SEE THE ONLINE DOCUMENTATION FOR EXAMPLES

from swgpy.object import *
from . import base

class Template(BaseTemplate):
	name = "object/creature/npc/base/shared_gran_base_male.iff"
	is_prototype = False
	
	def create(self, kernel, params):
		result = Creature()		
		init(kernel, params, result)
		
		return result

def init(kernel, params, result):
	try:
		base.init(kernel, params, result)
	except AttributeError:
		print('base.init doesnt exist')
	result.template = "object/creature/npc/base/shared_gran_base_male.iff"
	result.attribute_template_id = 9
	result.stfName("npc_name","gran_base_male")	
	
	#### BEGIN MODIFICATIONS ####		
	####  END MODIFICATIONS  ####
		
def loadTemplates(addTemplate):
	addTemplate(Template())