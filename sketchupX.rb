require 'sketchup.rb'

class Geom::Vector3d
    def self.X
	self.new [1,0,0]
    end
    def self.Y
	self.new [0,1,0]
    end
    def self.Z
	self.new [0,0,1]
    end
    def -@
	self.reverse
    end
end

class Sketchup::ComponentDefinition
    def add_face(*points, &block)
	face = entities.add_face *points
	face.instance_eval &block if block_given?
	face
    end
    def add_instance(*args)
	model.entities.add_instance self, *args
    end
end

class Sketchup::ConstructionLine
    def point_along(distance)
	position + distance*direction
    end
end

class Sketchup::Group
    def add_group(name=nil, &block)
	group = entities.add_group
	group.name = name unless name.nil?
	group.instance_eval &block if block_given?
	group
    end
    def add_instance(*args)
	entities.add_instance *args
    end
end

class Sketchup::Model
    def add_definition(name)
	d = definitions.add name
	yield d, name if block_given?
	d
    end
    def add_face(*points, &block)
	face = entities.add_face *points
	face.instance_eval &block if block_given?
	face
    end
    def add_group(name=nil, &block)
	group = entities.add_group
	group.name = name unless name.nil?
	group.instance_eval &block if block_given?
	group
    end
    def add_instance(*args)
	entities.add_instance *args
    end
    def clear!
	entities.clear!
	definitions.purge_unused
    end
end
