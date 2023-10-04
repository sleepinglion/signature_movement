$(document).ready(function() {
    mobile_menu=1;
    var csrf_token=$('meta[name="csrf-token"]').attr('content');

    $("a.simple_image").fancybox({
        'opacity'   : true,
        'overlayShow'        : true,
        'overlayColor': '#000000',
        'overlayOpacity'     : 0.9,
        'titleShow':true,
        'openEffect'  : 'elastic',
        'closeEffect' : 'elastic'
    });

    $('.custom-file-input').on('change', function() {
        let fileName = $(this).val().split('\\').pop();
        $(this).next('.custom-file-label').addClass("selected").html(fileName);
    });

    $('#no-sns-id').click(function(){
        $("#no-sns-login").show();
        $("#sns-login,#no-sns-id").hide();
        $("#no-sns-id").parent().hide();
    });

    function vote_click(){
        if($(this).find('span.already-vote').length) {
            alert('이미 투표하셨습니다.');
            return false;
        }

        var vote_link=$(this);
       // alert(vote_link.attr('href')+'.json')

        $.post(vote_link.attr('href')+'.json',{'_method':'put','authenticity_token':csrf_token},function(data){
            if(data.vote_up) {
                vote_link.find('span:first').addClass('already-vote');
                vote_link.find('span.text').text(' '+data.vote_up);
            } else {

            }
        },'json');
        return false;
    }

    function confirm_login_click(){
        if(confirm("로그인후에 사용가능합니다.\n지금 로그인 하시겠습니까?")) {
            location.href='/users/login';
        } else {
            return false;
        }
        return false;
    }

    // $('#sign_now').popover();

    $('#main_main nav li a').click(function(){
        var param='no_layout=true&no_nav=true';
        var tab=$.uri.setUri($(this).attr('href')).param("tab");

        if(tab) {
            param+='&tab='+tab;
        }

        var this_link=$(this);
        $('#main_layer').load('/home?'+param,function(){
            $('#main_main nav li a').removeClass('active');
            this_link.addClass('active');
            $('.vote a:not(".confirm_login")').click(vote_click);
            $('.confirm_login').click(confirm_login_click);
        });

        if (history && history.pushState) {
            history.pushState('','tab_'+tab,'/?tab='+tab);
        }

        return false;
    });

    $('.vote a:not(".confirm_login")').click(vote_click);
    $('.confirm_login').click(confirm_login_click);

    $("#report_main tbody tr,#compliment_main tbody tr").click(function(){
        location.href=$(this).find('a:first').attr('href');
    });

    $("#report_main tbody tr td a,#compliment_main tbody tr td a").click(function(){
        location.href=$(this).attr('href');
        return false;
    });

    $(".comment_form_only").click(function(){
        if($(this).parent().find('.comment_layer').length) {
            var comment_layer=$(this).parent().find('.comment_layer');
            if(comment_layer.is(':visible')) {
                comment_layer.slideUp();
            } else {
                comment_layer.slideDown();
            }
        } else {
            var mb=$(this).parent();
            var uid=$(this).parent().find('a:first').attr('href').split('/').pop();

            mb.append($('<div class="comment_layer"><div class="comment_form"></div><div class="comment_list"></div></div>'));
            mb.find('.comment_form').load($(this).attr('href')+'?no_layout=true',function(){
                $(this).find('form').submit(comment_form_submit);
            });
        }
        return false;
    });

    $(".comment_form_with_list").click(function(){
        if($(this).parent().find('.comment_layer').length) {
            var comment_layer=$(this).parent().find('.comment_layer');
            if(comment_layer.is(':visible')) {
                comment_layer.slideUp();
            } else {
                comment_layer.slideDown();
            }
        } else {
            var mb=$(this).parent();
            var uid=$(this).parent().find('a:first').attr('href').split('/').pop();

            mb.append($('<div class="comment_layer"><div class="comment_form"></div><div class="comment_list"></div></div>'));

            mb.find('.comment_form').load($(this).attr('href')+'?no_layout=true',function(){
                mb.find('.login_confirm').focus(function(){
                    $(this).blur();
                    if(confirm("로그인후에 사용가능합니다.\n지금 로그인 하시겠습니까?")) {
                        window.open($("#user_login_path").val()+'?popup=true',"","width=450, height=420, resizable=no, scrollbars=no, status=no;");
                    } else {
                        return false;
                    }
                });

                $(this).find('form').submit(comment_form_submit);
            });

            $.getJSON($(this).parent().find('a:first').attr('href')+'.json',function(data){
                if(data.length) {
                    $.each(data,function(index,value) {
                        mb.find('.comment_list').append($('<h5>'+value.username+'</h5><div class="comment">'+nl2br(value.comment)+'</div>'));
                    });
                }
            });
        }
        return false;
    });

    function comment_form_submit(e){
        e.preventDefault();

        var comment=$(this).find('textarea').val();

        if($.trim(comment) == '') {
            alert('댓글을 써주세요');
            $(this).find('textarea').focus();
            return false;
        }

        var mb=$(this).parent().parent().parent();

        $.post($(this).attr('action')+'.json',{'id':$(this).find('input[name="id"]').val(),'authenticity_token':csrf_token,'comment[comment]':comment},function(data){
            mb.find('textarea').val('');
            var new_comment=$('<h5>'+$("#username").text()+'</h5><div class="comment">'+nl2br(comment)+'</div>');
            mb.find('.comment_list').append(new_comment);
            new_comment.highlight();
        });
    }


    $("#faqCategoryList a.title").click(getList);
    $("#faqList dt a.title").click(getContent);

    function getList() {
        var tt=$(this);
        var parent=$(this).parent();

        $.getJSON($(this).attr('href')+'.json',function(data){
            $("#faqList").empty();
            if(data.faqs.length) {
                $.each(data.faqs,function(index,value){
                    var a=$('<a class="title" href="/faqs/'+value.id+'">'+value.title+'</a>').click(getContent);
                    if(data.admin) {
                        var div=$('<div class="sl_faq_menu"><a>수정</a> &nbsp; | &nbsp; <a rel="nofollow" data-method="delete" data-confirm="정말로 삭제합니까?">삭제</a></div>');
                        div.find('a:first').attr('href','/faqs/'+value.id+'/edit');
                        div.find('a:eq(1)').attr('href','/faqs/'+value.id);
                        $('<dt>').appendTo("#faqList").append(a).append(div);
                    } else {
                        $('<dt>').appendTo("#faqList").append(a);
                    }
                });
            } else {
                $('<dt>글이 없습니다.</dt>').appendTo("#faqList");
            }

            $("#faqCategoryList li").removeClass('on');
            parent.addClass('on');

            var faqCategoryId=$.uri.setUri(tt.attr('href')).param("faq_category_id");

            if(data.admin) {
                $("#faqCategoryList li .sl_faq_category_menu").remove();
                var dd=$('<div class="sl_faq_category_menu"><a>수정</a><br /><a rel="nofollow" data-method="delete" data-confirm="정말로 삭제합니까?">삭제</a></div>');
                dd.find('a:first').attr('href','/faq_categories/'+faqCategoryId+'/edit');
                dd.find('a:eq(1)').attr('href','/faq_categories/'+faqCategoryId);
                parent.append(dd);
            }

            $('#sl_bottom_menu a:eq(1)').attr('href','/faqs/new?faq_category_id='+faqCategoryId);
        });
        return false;
    }

    function getContent(){
        var parent=$(this).parent();
        $.getJSON($(this).attr('href')+'.json',function(value){
            if(parent.next().get(0)) {
                if(parent.next().get(0).tagName!='DD') {
                    parent.after('<dd>');
                }
            } else {
                parent.after('<dd>');
            }
            $("#faqList dt").removeClass('on');
            $("#faqList dd").hide();
            parent.addClass('on');
            parent.next().html('<p>'+nl2br(value.content)+'</p>').slideDown();
            if (history && history.pushState) {
                history.pushState('','faq_'+value.id,'/faqs/'+value.id);
            }
        });

        return false;
    }

    $("#new_user").submit(function(){
        var imgSize=$('#user_photo')[0].files[0].size;

        if(imgSize > (1 * 1024 * 1024)) {
            alert("첨부 이미지 파일은 1MB 이하여야 합니다.");
            return false;
        }

        if($.trim($("#user_url").val())=='https://' || $.trim($("#user_url").val())=='http://') {
            $("#user_url").val('');
        }

        return true;
    });

    $("#user_url").focus(function(){
        if($.trim($(this).val())=='') {
            $(this).val('https://');
        }
    });

    $("#mobile_menu").click(function(){
        if(mobile_menu) {
            $('.side_nav').animate({'left':'0'}, 400, 'easeOutCubic');
            mobile_menu=0;
        } else {
            $('.side_nav').animate({'left':'-500px'}, 400, 'easeInOutCubic');
            mobile_menu=1;
        }
    });

    function nl2br (str, is_xhtml) {
        var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br ' + '/>' : '<br>';
        return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
    }
});

(() => {
    'use strict'

    const getStoredTheme = () => localStorage.getItem('theme')
    const setStoredTheme = theme => localStorage.setItem('theme', theme)

    const getPreferredTheme = () => {
        const storedTheme = getStoredTheme()
        if (storedTheme) {
            return storedTheme
        }

        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
    }

    const setTheme = theme => {
        if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            document.documentElement.setAttribute('data-bs-theme', 'dark')
        } else {
            document.documentElement.setAttribute('data-bs-theme', theme)
        }
    }

    setTheme(getPreferredTheme())

    const showActiveTheme = (theme, focus = false) => {
        const themeSwitcher = document.querySelector('#bd-theme')

        if (!themeSwitcher) {
            return
        }

        const themeSwitcherText = document.querySelector('#bd-theme-text')
        const activeThemeIcon = document.querySelector('.theme-icon-active use')
        const btnToActive = document.querySelector(`[data-bs-theme-value="${theme}"]`)
        const svgOfActiveBtn = btnToActive.querySelector('svg use').getAttribute('href')

        document.querySelectorAll('[data-bs-theme-value]').forEach(element => {
            element.classList.remove('active')
            element.setAttribute('aria-pressed', 'false')
        })

        btnToActive.classList.add('active')
        btnToActive.setAttribute('aria-pressed', 'true')
        activeThemeIcon.setAttribute('href', svgOfActiveBtn)
        const themeSwitcherLabel = `${themeSwitcherText.textContent} (${btnToActive.dataset.bsThemeValue})`
        themeSwitcher.setAttribute('aria-label', themeSwitcherLabel)

        if (focus) {
            themeSwitcher.focus()
        }
    }

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
        const storedTheme = getStoredTheme()
        if (storedTheme !== 'light' && storedTheme !== 'dark') {
            setTheme(getPreferredTheme())
        }
    })

    window.addEventListener('DOMContentLoaded', () => {
        showActiveTheme(getPreferredTheme())

        document.querySelectorAll('[data-bs-theme-value]')
            .forEach(toggle => {
                toggle.addEventListener('click', () => {
                    const theme = toggle.getAttribute('data-bs-theme-value')
                    setStoredTheme(theme)
                    setTheme(theme)
                    showActiveTheme(theme, true)
                })
            })
    })
})()

jQuery.fn.highlight = function() {
    $(this).each(function() {
        var el = $(this);
        el.before("<div/>")
        el.prev()
            .width(el.width())
            .height(el.height())
            .css({
                "position": "absolute",
                "background-color": "#ffff99",
                "opacity": ".9"
            })
            .fadeOut(1000);
    });
}

