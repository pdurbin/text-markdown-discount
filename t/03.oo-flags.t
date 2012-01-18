use Test::More tests => 10;
use Text::Markdown::Discount;

{
    my $mkd = Text::Markdown::Discount->new(smart => 1);
    is(
        $mkd->markdown(qq{"Quoted text"}),
        qq{<p>&ldquo;Quoted text&rdquo;</p>\n},
    );
    $mkd = Text::Markdown::Discount->new(smart => 0);
    is(
        $mkd->markdown(qq{"Quoted text"}),
        qq{<p>"Quoted text"</p>\n},
    );

    my $output = Text::Markdown::Discount->new->smart->markdown(qq{"Quoted text"});
    is($output, qq{<p>&ldquo;Quoted text&rdquo;</p>\n});

    $output = Text::Markdown::Discount->new->smart(0)->markdown(qq{"Quoted text"});
    is($output, qq{<p>"Quoted text"</p>\n});

    $output = Text::Markdown::Discount->new->smart(1)->markdown(qq{"Quoted text"});
    is($output, qq{<p>&ldquo;Quoted text&rdquo;</p>\n});
}

{
    my $mkd = Text::Markdown::Discount->new(filter_html => 1);
    is(
        $mkd->markdown(qq{<p>para</p>}),
        qq{<p>&lt;p>para&lt;/p></p>\n},
    );
    $mkd = Text::Markdown::Discount->new(filter_html => 0);
    is(
        $mkd->markdown(qq{<p>para</p>}),
        qq{<p>para</p>\n\n},
    );

    my $output = Text::Markdown::Discount->new->filter_html->markdown(qq{<p>para</p>});
    is($output, qq{<p>&lt;p>para&lt;/p></p>\n});

    $output = Text::Markdown::Discount->new->filter_html(0)->markdown(qq{<p>para</p>});
    is($output, qq{<p>para</p>\n\n});

    $output = Text::Markdown::Discount->new->filter_html(1)->markdown(qq{<p>para</p>});
    is($output, qq{<p>&lt;p>para&lt;/p></p>\n});
}

