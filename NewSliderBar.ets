import Goods from '../data/Goods'
import GoodsCategory from '../data/GoodsCategory'
import goods from '../mocjs/goods'
import SiderBar from '../component/SiderBar'
import RightSiderBar from '../component/RightSiderBar'

/*左控制右商品列表
 版本:v1.0
 开发者:白日梦想家*/

@Entry
@Component
export default struct NewSliderBar {
  //点击变颜色设置颜色变量
  // @State mycolor:Color=Color.Yellow
  // @State myitem:string="
  //主组件状态，设置一个开关控制左侧栏变红
  @State myswitch: number = -1
  @State newitem: Array<Goods> = []

  //左边是分类，右边是分类条目
  build() {
    Flex({ direction: FlexDirection.Row }) {
      Scroll() {
        Flex({ direction: FlexDirection.Column }) {
          ForEach(goods, (myitem: GoodsCategory, index: number) => {
            //双向传递，值会变化，必须用$
            SiderBar({
              item: myitem,
              myitemlist: $newitem,
              control_switch: this.myswitch == index,
              onClickAction: () => {
                this.myswitch = index
              }
            })
            //子类组件不可以加点方法
            // .onClick(()=>{
            //   this.myswitch=index
            //   //验证myswitc值是否被修改
            //   console.info(this.myswitch+"")
            // })
          })
        }
        .width("30%")
        .height("110%")
        .backgroundColor(Color.Yellow)
      }

      Scroll() {
        Flex({ direction: FlexDirection.Column }) {
          //显示全部数据
          // ForEach(goods, (item: GoodsCategory) => {
          //   ForEach(item.courseList, (newitem: Goods) => {
          //     RightSiderBar({myitem:newitem})
          //   })
          // })
          //根据种类显示右侧数据
          ForEach(this.newitem, (mynewitem: Goods) => {
            RightSiderBar({ myitem: mynewitem })
          })
        }
        .width("70%")
      }
    }

  }
}

