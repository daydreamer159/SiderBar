import GoodsCategory from '../data/GoodsCategory'
import Goods from '../data/Goods'

@Component
export default struct OtherSiderBar {
  //子类调用父类方法
  onClickAction = () => {
  }
  //组件接受参数@Prop,单项传递
  @Prop item: GoodsCategory
  //组件状态
  // @State mycolor:Color=Color.Yellow
  //双向传递,传给父类
  // @Link myitemlist: Array<Goods>
  @Prop control_switch: boolean
  @Link mynewoffset:number
  build() {
    Text(this.item.classifyName)
      .height(70)
      .width(120)
      .padding(10)//开关决定颜色，组件状态mycolor无用了
      .backgroundColor(this.control_switch ? Color.Red : Color.Yellow)
      .onClick(() => {
        //forEach全变色，想要单个变色需要把颜色变为私有属性
        // this.mycolor=this.mycolor==Color.Yellow?Color.Red:Color.Yellow
        //每点击一次又一个courselist，传给父类
        // this.myitemlist = this.item.courseList
        let font_cate:number=this.item.classifyId-1
        //每类数据均等
        this.mynewoffset=-130*font_cate*6
        //子组件执行方法 this.方法名
        this.onClickAction()
        // if(item.mycolor==undefined || item.mycolor==Color.Yellow){
        //   item.mycolor=Color.Red
        // }else{
        //   item.mycolor=Color.Yellow
        // }
      })
  }
}