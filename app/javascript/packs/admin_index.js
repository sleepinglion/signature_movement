$(document).ready(function(){
    $('.custom-file-input').on('change', function() {
        let fileName = $(this).val().split('\\').pop();
        $(this).next('.custom-file-label').addClass("selected").html(fileName);
    });

    $(document).on('change', '.custom-control-input', function (e) {
        let c_checked = e.target.checked;

        if(window.location.port==80 || window.location.port==443 ) {
            var port='';
        } else {
            var port=':' + window.location.port;
        }

        var param_name=$(this).attr('id').split('_display')[0];

        if(c_checked) {
            $(this).parent().find('.custom-control-label').text('표시함').closest('tr').effect('highlight');
        } else {
            $(this).parent().find('.custom-control-label').text('숨김').closest('tr').effect('highlight');
        }

        var param={_method: 'put', authenticity_token:$('meta[name="csrf-token"]').attr('content')}
        var path=window.location.pathname.split('/admin/')[1];
        var url=window.location.protocol+'//'+window.location.hostname+port+'/admin/'+path+'/'+$(this).val()+'.json';


        param[param_name]={enable:c_checked};
        $.post(url,param,function(data){

        },'json');
    });

    $('#parent_address_id').change(function(){
        var csrf_token=$('meta[name="csrf-token"]').attr('content');
        var parent_address_id=$(this).val();

        $.getJSON('/addresses.json',{parent_address_id: parent_address_id,csrf_token: csrf_token},function(data){
            $('#address_id').empty();
            $.each(data,function(index,value){
                var option=$('<option value="'+value.id+'">'+value.title+'</option>');
                $('#address_id').append(option);
            });

            $('#address_id').effect('highlight').focus();
        });
    });

    $('#speciality_category_id').change(function(){
        var csrf_token=$('meta[name="csrf-token"]').attr('content');
        var speciality_category_id=$(this).val();

        $.getJSON('/specialities.json',{speciality_category_id: speciality_category_id,csrf_token: csrf_token},function(data){
            $('#speciality_id').empty();
            $.each(data,function(index,value){
                var option=$('<option value="'+value.id+'">'+value.title+'</option>');
                $('#speciality_id').append(option);
            });

            $('#speciality_id').effect('highlight').focus();
        });
    });

    $('#myModal').on('show.bs.modal', function (e) {
        if (!data) return e.preventDefault(); // stops modal from being shown

        if($(this).attr('title')) {
            $('#myModal .modal-header h3').text($(this).attr('title'));
        } else {
            $('#myModal .modal-header h3').text('사용자정보');
        }
    });

    $(".btn-close").click(function(){
        $(this).parent().parent().parent().remove();
        return false;
    });

    $("#messages .alert-success").fadeOut(5000,function(){
        var as=$(this);
        $("#messages").slideUp('slow',function(){
            as.remove();
            $("#messages").slideDown();
        });
    });
});