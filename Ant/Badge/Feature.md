| 参数  | 说明                                                                   | 类型  | 默认值 | 状态     |
| ----- | ---------------------------------------------------------------------- | ----- | ------ | -------- |
| color | 小圆点颜色                                                             | Color | -      | Done |
| count | 展示的数字，大于 overflowCount 时显示为 ${overflowCount}+，为 0 时隐藏 | int | -      | Done |
| dot | 不展示数字，只有一个小红点| boolean | false      | Done |
| offset | 设置状态点的位置偏移| point | -      | On going |
| overflowCount | 展示封顶的数字值| int | 99      | Done |
| showZero | 当数值为 0 时，是否展示 Badge| boolean | false      | Done |
| size | 在设置了 count 的前提下有效，设置小圆点的大小 | default, small | false | Done |
| status | 设置 Badge 为状态点 | success, processing, default, error, warning | false      | Done |