require 'spec_helper'

describe Api::V1::PageviewsController do
  let!(:website) { Website.create(key: '4k5n245j625k23nrg')}

  describe '#preflight' do
    subject { post "/api/v1/pageviews/preflight", data; response }
    let(:data) {
      {"url" => "http://test.com",
       "website_key" => "4k5n245j625k23nrg",
       "pageview_key" => "3kjn234jk23n4tk4her",
       "visitor_key" => "49tuhiarf9q834tn34k3t",
       "timestamp" => "123456671"
      }
    }

    its(:status) { should eq 200 }

    it 'returns success' do
      json_response = JSON.parse(subject.body)
      json_response.keys.should include('success')
      json_response.keys.should include('send_html')
    end
  end

  describe '#create' do
    subject { post "/api/v1/pageviews", data; response }
    let(:data) {
      {"url" => "http://test.com",
       "website_key" => "4k5n245j625k23nrg",
       "pageview_key" => "3kjn234jk23n4tk4her",
       "visitor_key" => "49tuhiarf9q834tn34k3t",
       "window_width" => "1200",
       "window_height" => "900",
       "timestamp" => "123456671",
       "page_html" => <<EOS
       <html lang="en-us"><head> <meta charset="utf-8"> <title>HTML5 Boilerplate: The web's most popular front-end template</title> <meta name="description" content="HTML5 Boilerplate is a professional front-end template for building fast, robust, and adaptable web apps or sites. Spend more time developing and less time reinventing the wheel."> <meta name="viewport" content="width=device-width, initial-scale=1"> <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open Sans:400,700"> <link rel="stylesheet" href="css/main-7b3fecba68527e3c683b5ffed5a0c131.min.css"> <script src="//www.google-analytics.com/ga.js"></script><script id="twitter-wjs" src="http://platform.twitter.com/widgets.js"></script><script src="js/html5.js"></script> <style type="text/css"></style></head> <body style="zoom: 1;" data-twttr-rendered="true"> <div class="container"> <header class="site-header cf" role="banner"> <div class="site-logo"> HTML5 <span class="star">★</span> Boilerplate </div> <ul class="site-nav inline-block-list"> <li><a href="https://github.com/h5bp/html5-boilerplate" data-ga-category="Outbound links" data-ga-action="Nav click" data-ga-label="Source code">Source code</a></li> <li><a href="https://github.com/h5bp/html5-boilerplate/blob/v4.3.0/doc/TOC.md" data-ga-category="Outbound links" data-ga-action="Nav click" data-ga-label="Docs">Docs</a></li> <li><a href="http://h5bp.github.com" data-ga-category="Outbound links" data-ga-action="Nav click" data-ga-label="Other projects">Other projects</a></li> </ul> </header><!-- end site-header --> <div class="site-promo"> <h1>The web’s most popular front-end template</h1> <p class="description">HTML5 Boilerplate helps you build <strong>fast</strong>, <strong>robust</strong>, and <strong>adaptable</strong> web apps or sites. Kick-start your project with the combined knowledge and effort of 100s of developers, all in one little package.</p> <div class="cta-option"> <a class="btn-download" href="https://github.com/h5bp/html5-boilerplate/zipball/v4.3.0" data-ga-category="Download" data-ga-action="Download - top" data-ga-label="v4.3.0"> <strong>Download</strong> <span class="version">v4.3.0</span> </a> <a class="last-update" href="https://github.com/h5bp/html5-boilerplate/blob/v4.3.0/CHANGELOG.md"> See the CHANGELOG </a> </div> <div class="cta-option"> <a class="btn-download btn-download-alt" href="http://initializr.com" data-ga-category="Outbound links" data-ga-action="Get custom build" data-ga-label="v4.3.0"> Get a custom build </a> </div> </div><!-- end site-promo --> </div> <div class="site-content"> <div class="container"> <h2>Save time. Create with confidence.</h2> <div class="grid"> <div class="grid-cell"> <h3><span class="star">★</span> Analytics, icons, and more</h3> <p>A lean, mobile-friendly HTML template; optimized Google Analytics snippet; placeholder touch-device icons; and docs covering dozens of extra tips and tricks.</p> </div> <div class="grid-cell"> <h3><span class="star">★</span> Normalize.css and helpers</h3> <p>Includes <a href="http://necolas.github.com/normalize.css/">Normalize.css</a> v1 — a modern, HTML5-ready alternative to CSS resets — and further base styles, helpers, media queries, and print styles.</p> </div> <div class="grid-cell"> <h3><span class="star">★</span> jQuery and Modernizr</h3> <p>Get the latest minified versions of two best-of-breed libraries: <a href="http://jquery.org/">jQuery</a> (via Google’s CDN, with local fallback) and the <a href="http://modernizr.com/">Modernizr</a> feature detection library.</p> </div> <div class="grid-cell"> <h3><span class="star">★</span> High performance</h3> <p>Apache settings to help you deliver excellent site performance. We independently maintain <a href="https://github.com/h5bp/server-configs">server configs</a>, a <a href="https://github.com/h5bp/node-build-script">node build script</a>, and an <a href="https://github.com/h5bp/ant-build-script">ant build script</a>.</p> </div> </div> <div class="flex-embed"> <iframe width="720" height="540" src="http://www.youtube.com/embed/WkLO-q2wC80?theme=light" frameborder="0" allowfullscreen=""></iframe> </div> <h2>Who uses HTML5 Boilerplate?</h2> <p class="in-the-wild"> <a href="http://www.projectrebrief.com/">Google</a>, <a href="http://www.microsoft.com/surface/">Microsoft</a>, <a href="http://data.nasa.gov/">NASA</a>, <a href="http://www.nikeskateboarding.com/">Nike</a>, <a href="http://www.barackobama.com/">Barack Obama</a>, <a href="http://a-class.mercedes-benz.com/">Mercedes-Benz</a>, <a href="http://www.itv.com/news/">ITV News</a>, <a href="http://www.astuteclass.com/">BAE Systems</a>, <a href="http://creativecommons.org/">Creative Commons</a>, <a href="http://auspost.com.au/">Australia Post</a>, <a href="http://www.ew.com/">Entertainment Weekly</a>, <a href="http://www.racinggreen.co.uk/">Racing Green</a>, and <a href="https://github.com/h5bp/html5-boilerplate/wiki/sites">many more</a>. </p> <div class="cta-option"> <a class="btn-download" href="https://github.com/h5bp/html5-boilerplate/zipball/v4.3.0" data-ga-category="Download" data-ga-action="Download - bottom" data-ga-label="v4.3.0"> <strong>Download</strong> <span class="version">v4.3.0</span> </a> </div> </div> </div> <aside class="aside"> <div class="container"> <ul class="inline-block-list"> <li><a href="https://github.com/h5bp/html5-boilerplate/issues" data-ga-category="Outbound links" data-ga-action="Footer click" data-ga-label="Report issues"> <img class="icon" src="http://www.google.com/s2/favicons?domain=github.com" alt=""> Report issues </a></li> <li><a href="http://stackoverflow.com/questions/tagged/html5boilerplate" data-ga-category="Outbound links" data-ga-action="Footer click" data-ga-label="Help on Stack Overflow"> <img class="icon" src="http://www.google.com/s2/favicons?domain=stackoverflow.com" alt=""> Help on Stack Overflow </a></li> <li><a href="http://h5bp.net" data-ga-category="Outbound links" data-ga-action="Footer click" data-ga-label="View the showcase"> <img class="icon" src="http://24.media.tumblr.com/avatar_c11b98176b89_16.png" alt=""> View the showcase </a></li> </ul> </div> </aside><!-- end aside --> <footer class="site-footer" role="contentinfo"> <div class="container"> <p> <iframe id="twitter-widget-0" scrolling="no" frameborder="0" allowtransparency="true" src="http://platform.twitter.com/widgets/tweet_button.1382126667.html#_=1382262711246
EOS
      }
    }

    its(:status) { should eq 200 }

    it 'returns success' do
      json_response = JSON.parse(subject.body)
      json_response.keys.should include('success')
    end

    it 'creates pageview' do
      subject
      Pageview.count.should eq 1
      Pageview.last.page_html.should eq data["page_html"]
      Pageview.last.window_width.should eq 1200
      Pageview.last.window_height.should eq 900
      Pageview.last.timestamp.should eq 123456671
    end
  end
end