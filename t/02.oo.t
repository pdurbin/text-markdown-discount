use Test::More tests => 3;
use Text::Markdown::Discount;

{
    is(
        Text::Markdown::Discount->new->markdown('Hello, world.'),
        qq{<p>Hello, world.</p>\n},
    );
}

{
    is(
        Text::Markdown::Discount->new->markdown('_Hello, world_!'),
        qq{<p><em>Hello, world</em>!</p>\n},
    );
}

{
    is(
        Text::Markdown::Discount->new->markdown('4 < 5'),
        qq{<p>4 &lt; 5</p>\n},
    );
}
