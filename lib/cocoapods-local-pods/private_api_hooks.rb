
LocalPodFile = 'localPodfile'

module Pod
  class Podfile
    module DSL

      class FakePodfile
        @@dependencies = {}

        def dependencies
          return @@dependencies
        end

        def initialize()
          contents ||= File.open(LocalPodFile, 'r:utf-8', &:read)

          if contents.nil?
            UI.puts "#{LocalPodFile} not exist or empty"
            return
          end

          instance_eval(contents)
        end

        def pod(name = nil, *requirements)
          unless name
            raise StandardError, 'A dependency requires a name.'
          end

          dependencies[name] = requirements
        end
      end

      @@localPodfile = FakePodfile.new()

      # ======================
      # ==== PATCH METHOD ====
      # ======================
      swizzled_pod = instance_method(:pod)

      define_method(:pod) do |name, *requirements|
        if @@localPodfile.dependencies.has_key?(name)
          swizzled_pod.bind(self).(name, *@@localPodfile.dependencies[name])
        else
          swizzled_pod.bind(self).(name, *requirements)
        end
      end

    end
  end
end
