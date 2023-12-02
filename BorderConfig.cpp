#include "BorderConfig.hpp"
#include <QMetaType>

BorderConfig::BorderConfig(QObject* parent) : QObject{ parent }
{
    qRegisterMetaType<BorderConfig>();
}
