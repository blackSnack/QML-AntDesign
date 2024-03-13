#pragma once
#include <QObject>
namespace Ant {
Q_NAMESPACE
enum Placement
{
    Top = 0,
    TopLeft,
    TopRight,
    Bottom,
    BottomLeft,
    BottomRight,
    Left,
    LeftTop,
    LeftBottom,
    Right,
    RightTop,
    RightBottom
};
Q_ENUMS(Placement);

enum Trigger
{
    Hover = 0x1,
    Focus = 0x2,
    Click = 0x4
};
Q_ENUMS(Trigger);

enum Size
{
    Small,
    Middle,
    Large,
};
Q_ENUMS(Size);
} // namespace Ant
