#pragma once
#define HALF_F(value) (static_cast<qreal>(value) / 2.0)
#define DOUBLE_F(value) (static_cast<qreal>(value) * 2.0)
#define CREATE_QML_PROPERTY(type, name, writeName, ...) \
Q_PROPERTY(type name READ name WRITE set##writeName NOTIFY name##Changed FINAL) \
private: \
type name##M {__VA_ARGS__};\
public: \
Q_SIGNAL void name##Changed();\
void set##writeName(const type & value) \
{\
    if (value != name##M)\
    {\
        name##M = value;\
        emit name##Changed();\
    }\
}\
type name() const\
{\
    return name##M; \
}

