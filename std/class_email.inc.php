<?php if(!function_exists('startedIndexPhp')) { header("location:../index.php"); exit();}
# streber - a php based project management system
# Copyright (c) 2005 Thomas Mann - thomas@pixtur.de
# Distributed under the terms and conditions of the GPL as stated in docs/license.txt

require_once(confGet('DIR_STREBER') . './std/mail.inc.php');

/* Sending e-mails with phpMailer. Going to go ahead and let to class mostly work like it has then implement phpMailer in the send() method */
require_once(confGet('DIR_STREBER') . 'std/phpmailer/PHPMailerAutoload.php');

/**
 * This base class handles the necessary work to send an Email to a given recipient:
 * - temporarily changing current user
 * - rendering of correct links to items
 * - providing correct linebreaks
 *
 * Deriving classes should overwrite buildSubject and buildBody
 *
 * Example usage:
 * $e= new Email($current_user);
 * $e->send();
 *
 * @author      Thomas Mann
*/

class Email
{
    protected $keep_cur_user;
    protected $recipient;
    protected $body_html;
    protected $body_plaintext;
    protected $from_domain;
    protected $url;
    public    $errors;
    protected $from;
    public      $to;

    public function __construct($person)
    {
    	$from = ( confGet('EMAIL_FROM') == "" ? "donotreply@" . $this->from_domain : confGet('EMAIL_FROM') );
    	$from_name = ( confGet('EMAIL_FROM_NAME') == "" ? confGet('APP_NAME') . "Notification" : confGet('EMAIL_FROM_NAME') );
        $this->errors= Array();
        $this->recipient= $person;
        $this->url= confGet('SELF_PROTOCOL').'://'.confGet('SELF_URL');
        $this->from_domain = confGet('SELF_DOMAIN');;
        $this->from = array($from_name, $from);
        $this->reply = $from;
        $this->to = $person->getValidEmailAddress();
        if(!$this->to) {
            $this->errors[]= _('no person does not have an Email-address','notification');
        }

        $this->setRecipient($person);
        $this->initSubject();
        $this->initBody();
        $this->resetCurrentUser();
    }


    protected function initBody()
    {
        $this->body_plaintext = $this->body_html = "...insert text here...";
    }


    /**
    * Sends the mail
    *
    * @returns
    * - true on success
    * - html-error on failure
    *
    * NOTE some tips used from Jon Webb [Madrid&London]
    *                          http://www.php.net/manual/en/ref.mail.php#61644
    */
    public function send()
    {
        if($this->errors) {
            return false;
        }
		try{
			log_message("Sending e-mail to " . $this->to);
			log_message(confGet('SMTP') . ":" . confGet('SMTP_PORT'));
			$mailer = new phpMailer(true);
			$mailer->IsSMTP();
			$mailer->Host = confGet('SMTP');
			$mailer->Port = confGet('SMTP_PORT');
			if ( confGet('SMTP_USE_AUTH') == true ){
				$mailer->SMTPAuth = true;
				$mailer->Username = confGet('SMTP_USERNAME');
				$mailer->Password = confGet('SMTP_PASSWORD');
				$mailer->SMTPSecure = confGet('SMTP_SECURE');
			}
			$mailer->SetFrom($this->from[1],$this->from[0]);
			$mailer->AddReplyTo($this->from[1],$this->from[0]);
			$mailer->Subject = $this->subject;
			$mailer->AddAddress($this->to, $this->recipient->name);
			$mailer->MsgHTML($this->body_html);
			$mailer->Send();
		} catch (phpmailerException $e){
			log_message( $e->errorMessage() . $this->to . " <" . $this->recipient->name .">", ERROR_FATAL);
			$error = asHtml( $e->errorMessage() . ' ("'. $this->to. '" <'. $this->recipient->name .'>)' );
			return $error;
		}
        return true;
    }

    private function getEndOfLine()
    {
        if (strtoupper(substr(PHP_OS,0,3)=='WIN')) {
            $eol="\n\r";
        }
        elseif (strtoupper(substr(PHP_OS,0,3)=='MAC')) {
            $eol="\n\r";
        }
        else {
            $eol="\n\r";
        }
    }

    /**
    * Temporary overwrite the current-user to obey item-visibility and current language settings
    * MUST BE RESET BEFORE LEAVING THIS FUNCTION by calling resetCurrentUser
    */
    private function setRecipient($person)
    {
        global $auth;
        $this->keep_cur_user= $auth->cur_user;
        $auth->cur_user= $person;
        $this->recipient= $person;
        setLang($person->language);
    }

    private function resetCurrentUser()
    {
        global $auth;
        $auth->cur_user = $this->keep_cur_user;
        if(isset($auth->cur_user->language)) {
            setLang($auth->cur_user->language);
        }
    }

    protected function getItemLink($id, $title)
    {
        return "<a href='" . $this->getUrlToItem($id) . "'>". asHtml($title) . "</a>";
    }

    /**
    * Depending on the MOD_REWRITE-setting, urls inside the Email have to look differently
    */
    protected function getUrlToItem($id)
    {
        $url= confGet('SELF_PROTOCOL').'://'.confGet('SELF_URL'); # returns something like http://localhost/streber/index.php

        if(confGet('USE_MOD_REWRITE')) {
            $url= str_replace('index.php','',$url);
            return $url . "/" . intval($id);
        }
        else {
            return $url . "?go=itemView&id=" . intval($id);
        }
    }
}
