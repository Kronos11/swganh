#### NOTICE: THIS FILE IS AUTOGENERATED
#### MODIFICATIONS MAY BE LOST IF DONE IMPROPERLY
#### PLEASE SEE THE ONLINE DOCUMENTATION FOR EXAMPLES

from swgpy.object import *
from . import base

class Template(BaseTemplate):
	name = "object/tangible/food/base/shared_alcoholic_drink_base.iff"
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
	result.template = "object/tangible/food/base/shared_alcoholic_drink_base.iff"
	result.attribute_template_id = 5
	result.stfName("craft_food_ingredients_n","base_alcoholic_drink")	
	
	#### BEGIN MODIFICATIONS ####		
	####  END MODIFICATIONS  ####
		
def loadTemplates(addTemplate):
	addTemplate(Template())