#### NOTICE: THIS FILE IS AUTOGENERATED
#### MODIFICATIONS MAY BE LOST IF DONE IMPROPERLY
#### PLEASE SEE THE ONLINE DOCUMENTATION FOR EXAMPLES

from swgpy.object import *
from . import base

class Template(BaseTemplate):
	name = "object/tangible/wearables/base/shared_base_bracer_upper_r.iff"
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
	result.template = "object/tangible/wearables/base/shared_base_bracer_upper_r.iff"
	result.attribute_template_id = 11
	result.stfName("wearables_name","bracer_s01")	
	
	#### BEGIN MODIFICATIONS ####		
	####  END MODIFICATIONS  ####
		
def loadTemplates(addTemplate):
	addTemplate(Template())