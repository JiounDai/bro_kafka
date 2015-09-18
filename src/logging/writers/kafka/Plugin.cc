// See the file  in the main distribution directory for copyright.


#include "plugin/Plugin.h"

#include "Kafka.h"

namespace plugin {
namespace Bro_KafkaWriter {

class Plugin : public plugin::Plugin {
public:
	plugin::Configuration Configure()
		{
		AddComponent(new ::logging::Component("Kafka", ::logging::writer::Kafka::Instantiate));

		plugin::Configuration config;
		config.name = "Bro::KafkaWriter";
		config.description = "Kafka log writer";
		return config;
		}
} plugin;

}
}
