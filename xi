从接口上讲一个下拉刷新应该提供如下几个方法
onRefresh()
onPullDistance()
onPullEnable
setRefreshing(false);
setHeaderView

分析：	提供刷新接口，用于加载数据，
	提供下拉距离用于自定义动画
  提供刷新结束关闭方法
	提供添加头布局和尾布局的方法。
这样对外的接口就是齐全的。

从效果上分析：
1：首先一个下拉这里有一个move属性
2：再然后释放 这里有一个自定义动画属性
3：自定义动画完成之后有一个恢复动画。
然后代码也是按照这个流程走的。

这里主要分析代码流程：

首先viewgroup的消息传递顺序是这样的：
dispatchTouchEvent--->onInterceptTouchEvent-----> onTouchEvent---->onclick
因为是下拉刷新只需要改写 消息的拦截事件和touch事件。

下面分析onInterceptTouchEvent所做的事。
1：记录按下的位置
2：设置下拉距离标志
3：下拉状态下拦截子view消息分发。

再分析下 onTouchEvent所做的事
Move：做move的动画
Up 和cancle  启动恢复动画。
