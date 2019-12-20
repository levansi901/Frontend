<?php

namespace App\View\Helper;
use Cake\View\Helper;

class UtilitiesHelper extends Helper {

    public function getThumb($src = null, $size = null){    
        if(empty($src)) return null;

        $url_thumb = str_replace(CDN_DOMAIN_URL . '/uploads/' , CDN_DOMAIN_URL . '/thumbs/', $src);
        $path_info = pathinfo($url_thumb);

        $basename = !empty($path_info['basename']) ? $path_info['basename'] : null;
        $filename = !empty($path_info['filename']) ? $path_info['filename'] : null;
        $extension = !empty($path_info['extension']) ? $path_info['extension'] : null;
    
        if(!empty($basename) && !empty($filename) && !empty($extension)){
            switch ($size) {
                case 50:
                    $url_thumb = str_replace($basename, $filename . '_thumb_50.' . $extension, $url_thumb);
                    break;
                case 150:
                    $url_thumb = str_replace($basename, $filename . '_thumb_50.' . $extension, $url_thumb);
                    break;
                case 250:
                    $url_thumb = str_replace($basename, $filename . '_thumb_50.' . $extension, $url_thumb);
                    break;
                case 350:
                    $url_thumb = str_replace($basename, $filename . '_thumb_50.' . $extension, $url_thumb);
                    break;
            }
        }
        return $url_thumb;
    }
}
