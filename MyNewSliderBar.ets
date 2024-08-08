import Goods from '../data/Goods'
import GoodsCategory from '../data/GoodsCategory'
import goods from '../mocjs/goods'
import RightSiderBar from '../component/RightSiderBar'
import OtherSiderBar from '../component/OtherSiderBar'
import { StartOptions } from '@kit.AbilityKit'

/*左右联动的商品列表
 版本:v2.0
 开发者:白日梦想家*/
@Entry
@Component
export default struct MyNewSliderBar {
  //点击变颜色设置颜色变量
  // @State mycolor:Color=Color.Yellow
  // @State myitem:string="
  //主组件状态，设置一个开关控制左侧栏变红
  @State myswitch: number = 0
  // @State newitem: Array<Goods> = []
  @State myoffset: number = 0
  private left_scroller: Scroller = new Scroller()
  private rigtht_scroller: Scroller = new Scroller()

  @Builder
  myHeaderBuilder(classifyName: string) {
    Flex({ direction: FlexDirection.Column }) {
      Text(classifyName)
        .fontSize(20)
    }
    .backgroundColor(Color.Pink)
    .width("100%")
    .padding(10)
  }
  private  myScrollTodex(index:number,isCheck:boolean){
    this.myswitch=index
    //isCheck为true右边滚动
    if(isCheck){
      this.rigtht_scroller.scrollToIndex(index)
    }else {
      this.left_scroller.scrollToIndex(index)
    }
  }
  build() {
    //左边是分类，右边是分类条目
    Flex({ direction: FlexDirection.Row }) {
      List({ scroller: this.left_scroller }) {
        // Flex({ direction: FlexDirection.Column }) {
        ForEach(goods, (myitem: GoodsCategory, index: number) => {
          ListItem() {
            //双向传递，值会变化，必须用$
            OtherSiderBar({
              item: myitem,
              // myitemlist: $newitem
              mynewoffset: $myoffset,
              control_switch: this.myswitch == index,
              onClickAction: () => {
                //右滚动
                this.myScrollTodex(index,true)
                // //格式变红
                // this.myswitch = index
                // //滑动
                // this.rigtht_scroller.scrollToIndex(index)
              }
            })
          }
        })
      }
      .width("30%")
      .height("110%")
      .backgroundColor(Color.Yellow)

      List({ scroller: this.rigtht_scroller }) {
        // Flex({ direction: FlexDirection.Column }) {
        //显示全部数据
        ForEach(goods, (item: GoodsCategory) => {
          //分组标志
          ListItemGroup({
            //builder布局
            header: this.myHeaderBuilder(item.classifyName),
            space: 12
          })
          {//这里list可以让每个种类数据跟随上方name
            ForEach(item.courseList, (newitem: Goods) => {
            RightSiderBar({ myitem: newitem })
            //显示项ListItem()
          })}
        })
        //根据种类显示右侧数据
        // ForEach(this.newitem, (mynewitem: Goods) => {
        //   RightSiderBar({ myitem: mynewitem })
        // })
        // }
        // .width("70%")
        //offset偏移量
        // .offset({y:this.myoffset})
      }
      //左边滚动
      .onScrollIndex((start)=>this.myScrollTodex(start,false))
    }

  }
}

