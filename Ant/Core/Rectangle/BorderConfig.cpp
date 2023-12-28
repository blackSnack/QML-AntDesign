#include "BorderConfig.hpp"
#include <QMetaType>
namespace Ant
{

BorderConfig::BorderConfig(QObject* parent) : QObject{ parent }
{
    qRegisterMetaType<BorderConfig>();
}

}
