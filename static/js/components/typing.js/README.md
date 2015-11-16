# typing.js

A simple and lightweight jQuery plugin for type animations.

### Usage

Simply use jQuery's selection and call `type`:

```
...
$('p').type('Lorem ipsum dolor sit amet.')
...
```

You can even write animated sentences using the following code:

```
...
// Using underscore.js functions for simplicity
var taglineMessages = _.map($('ul#tagline__messages > li'), function(obj) { return $(obj).text() });
function typeArray($elem, array) {
	var text = _.first(array);
	if (text !== undefined) {
		$elem.type(text, {
			onFinish: function() {
				setTimeout(function() { typeArray($elem, _.tail(array)); }, 750);
			}
		});
	}
}
typeArray($('#tagline'), taglineMessages);
...
```

### More features?

The goal of this plugin is to be as lightweight and simple as posible, for more features check [typed.js](https://github.com/mattboldt/typed.js/)
