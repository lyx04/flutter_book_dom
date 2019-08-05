# flutter_book_dom
flutter实战书
## 修改国内镜像
将Google()、jcenter()修改成  
maven { url 'https://maven.aliyun.com/repository/google' }  
maven { url 'https://maven.aliyun.com/repository/jcenter' }  
maven { url 'http://maven.aliyun.com/nexus/content/groups/public'}  
## Form
TextEditingController设置输入框的controller
>>输入框可以通过单类中的onchang(v){print(v)}/initstate中的controll.addListener((){print(controll.text)})
>>从第三个元素开始选中后面的文字
>>>_controll.selection = TextSelection(baseOfft:2//偏移两个字符,ectenetOffset:controll.text.length)


