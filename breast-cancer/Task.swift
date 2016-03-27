//
//  Task.swift
//  Teste
//
//  Created by leonardo on 2/18/16.
//  Copyright © 2016 Leonardo. All rights reserved.
//

import UIKit
import ResearchKit
import ResearchKit.Private

enum Task : Int, CustomStringConvertible {
    case Consent
    case DailySurvey
    case WeeklySurvey
    case MonthlySurvey
    case Diary
    
    
    //Return an array with all tasks
    static var allCases : [Task] {
        return [.Consent, .DailySurvey, .WeeklySurvey, .MonthlySurvey, .Diary]
    }
    
    
    //MARK: CustomStringConvertible
    var description : String {
        switch self {
        case .Consent:
            return NSLocalizedString("Consentimentos", comment: "")
            
        case .DailySurvey:
            return NSLocalizedString("Check-in Diário", comment: "")
            
        case .WeeklySurvey:
            return NSLocalizedString("Questionário Semanal", comment: "")
            
        case .MonthlySurvey:
            return NSLocalizedString("Questionário Mensal", comment: "")
            
        case .Diary:
            return NSLocalizedString("Diário", comment: "")
        }
    }
    
    
    //Returns the new ORKTask
    var representedTask: ORKTask {
        switch self {
        case .Consent:
            return consentTask
            
        case .DailySurvey:
            return dailySurveyTask
            
        case .WeeklySurvey:
            return weeklySurveyTask
            
        case .MonthlySurvey:
            return monthlySurveyTask
            
        case .Diary:
            return diaryTask
            
        default:
            return emptyTask
        }
    }
    
    
    //MARK: Task creation
    private var emptyTask : ORKTask {
        return ORKOrderedTask(identifier: "empty", steps: nil)
    }
    
    
    public var consentTask: ORKOrderedTask {
        var steps = [ORKStep]()
        
        //Visual Consent
        let consentDocument = ConsentDocument
        let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
        steps += [visualConsentStep]
        
        //Signature + Review Consent
        let signature = ConsentDocument.signatures!.first as! ORKConsentSignature?
        signature?.title = "Assinatura"
        
        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
        reviewConsentStep.text = "Informações de consentimento"
        reviewConsentStep.reasonForConsent = "Você concorda com os termos da pesquisa?"
        steps += [reviewConsentStep]
        
        
        return ORKOrderedTask(identifier: "ConsentTasks", steps: steps)
    }
    
    
    public var dailySurveyTask: ORKOrderedTask {
        var steps = [ORKStep]()
        
        let introStep = ORKInstructionStep(identifier: "Intro Q Diario")
        introStep.title = NSLocalizedString("Questionário Diário", comment: "")
        introStep.text = NSLocalizedString("Siga as instruções a seguir para responder cada pergunta.", comment: "")
        steps += [introStep]
        
        let firstQuestion = ORKQuestionStep(identifier: "Q1 Diario", title: "Remédios", answer: ORKBooleanAnswerFormat())
        firstQuestion.text = NSLocalizedString("Você tomou seus medicamentos hoje?", comment: "")
        steps += [firstQuestion]
        
        //Case answer is NO
        let firstQuestionNo = ORKQuestionStep(identifier: "Q2 se Q1 NAO", title: "Remédios", answer: ORKBooleanAnswerFormat())
        firstQuestionNo.text = NSLocalizedString("Você deixou de tomar seus medicamentos hoje porque estava se sentindo bem?", comment: "")
        steps += [firstQuestionNo]
        
        //Case answer is "Feeling Weel"
        let firstQuestionNoGood = ORKQuestionStep(identifier: "Q3 se Q2 BEM", title: "Remédios", answer: ORKBooleanAnswerFormat())
        firstQuestionNoGood.text = NSLocalizedString("Você lembrou de tomar seu remédio na hora certa?", comment: "")
        steps += [firstQuestionNoGood]
        
        //Case answer is "Feeling bad"
        let feelingStep = ORKQuestionStep(identifier: "Q3 se Q2 RUIM", title: "Remédios", answer: ORKTextAnswerFormat(maximumLength: 255))
        feelingStep.title = "Sentimentos"
        feelingStep.text = "O que você está sentindo?"
        steps += [feelingStep]
        
        //Add summary step
        let summaryStep = ORKInstructionStep(identifier: "Sumario Diario")
        summaryStep.title = NSLocalizedString("Agradecimentos", comment: "")
        summaryStep.text = NSLocalizedString("Seus dados foram coletados. Obrigado por participar da nossa pesquisa!", comment: "")
        steps += [summaryStep]
        
        return ORKOrderedTask(identifier: "Tarefa Questionario Diario", steps: steps)
    }
    
    
    public var weeklySurveyTask : ORKOrderedTask {
        var steps = [ORKStep]()
        
        let introStep = ORKInstructionStep(identifier: "Intro Q Semanal")
        introStep.title = NSLocalizedString("Questionário Semanal", comment: "")
        introStep.text = NSLocalizedString("Siga as instruções a seguir para responder cada pergunta.", comment: "")
        steps += [introStep]
        
        let questionStep = ORKQuestionStep(identifier: "Q1 Semanal", title: NSLocalizedString("Doença", comment: ""), answer: ORKBooleanAnswerFormat())
        questionStep.text = NSLocalizedString("Você teve fogachos (calorão)?", comment: "")
        steps += [questionStep]
        
        let dayBeging = ORKQuestionStep(identifier: "Inicio Dores",
            title: "Fogachos",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayBeging.text = "Quando iniciou?"
        steps += [dayBeging]
        
        let dayEnd = ORKQuestionStep(identifier: "Fim Dores",
            title: "Fogachos",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayEnd.text = "Quando terminou?"
        steps += [dayEnd]
        
        let questionStep2 = ORKQuestionStep(identifier: "Q2 Semanal", title: NSLocalizedString("Retenção de Líquido", comment: ""), answer: ORKBooleanAnswerFormat())
        questionStep2.text = NSLocalizedString("Você teve retenção de líquidos (ficou inchada)?", comment: "")
        steps += [questionStep2]
        
        let dayBeging2 = ORKQuestionStep(identifier: "Inicio Retencao",
            title: "Retenção de Líquidos",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayBeging2.text = "Quando iniciou?"
        steps += [dayBeging2]
        
        let dayEnd2 = ORKQuestionStep(identifier: "Fim Retencao",
            title: "Retenção de Líquidos",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayEnd2.text = "Quando terminou?"
        steps += [dayEnd2]
        
        let questionStep3 = ORKQuestionStep(identifier: "Q3 Semanal", title: NSLocalizedString("Nauseas", comment: ""), answer: ORKBooleanAnswerFormat())
        questionStep3.text = NSLocalizedString("Você teve náusea e/ou vômito?", comment: "")
        steps += [questionStep3]
        
        let dayBeging3 = ORKQuestionStep(identifier: "Inicio Nauseas",
            title: "Náuseas",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayBeging3.text = "Quando iniciou?"
        steps += [dayBeging3]
        
        let dayEnd3 = ORKQuestionStep(identifier: "Fim Nauseas",
            title: "Náuseas",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayEnd3.text = "Quando terminou?"
        steps += [dayEnd3]
        
        
        let questionStep4 = ORKQuestionStep(identifier: "Q4 Semanal", title: NSLocalizedString("Fadiga", comment: ""), answer: ORKBooleanAnswerFormat())
        questionStep4.text = NSLocalizedString("Você teve fadiga (cansaço)?", comment: "")
        steps += [questionStep4]
        
        let dayBeging4 = ORKQuestionStep(identifier: "Inicio Fadiga",
            title: "Fadiga",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayBeging4.text = "Quando iniciou?"
        steps += [dayBeging4]
        
        let dayEnd4 = ORKQuestionStep(identifier: "Fim Fadiga",
            title: "Fadiga",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayEnd4.text = "Quando terminou?"
        steps += [dayEnd4]
        
        //Add summary step
        let summaryStep = ORKInstructionStep(identifier: "Sumario Semanal")
        summaryStep.title = NSLocalizedString("Agradecimentos", comment: "")
        summaryStep.text = NSLocalizedString("Seus dados foram coletados. Obrigado por participar da nossa pesquisa!", comment: "")
        steps += [summaryStep]
        
        return ORKOrderedTask(identifier: "WeeklySurveyTask", steps: steps)
    }
    
    
    public var monthlySurveyTask : ORKOrderedTask {
        var steps = [ORKStep]()
        
        let introStep = ORKInstructionStep(identifier: "Intro Mensal")
        introStep.title = NSLocalizedString("Questionário Mensal", comment: "")
        introStep.text = NSLocalizedString("Siga as instruções a seguir para responder cada pergunta.", comment: "")
        steps += [introStep]
        
        let questionStep = ORKQuestionStep(identifier: "Q1 Mensal", title: NSLocalizedString("Doença", comment: ""), answer: ORKBooleanAnswerFormat())
        questionStep.text = NSLocalizedString("Você teve evento tromboembólico?", comment: "")
        steps += [questionStep]
        
        let dayBeging = ORKQuestionStep(identifier: "Inicio Tromboembolico",
            title: "Evento Tromboembólico",
            answer: ORKDateAnswerFormat(style: .DateAndTime))
        dayBeging.text = "Quando iniciou?"
        steps += [dayBeging]
        
        let questionStep2 = ORKQuestionStep(identifier: "Q2 Mensal", title: NSLocalizedString("Doença", comment: ""), answer: ORKBooleanAnswerFormat())
        questionStep2.text = NSLocalizedString("Você teve elevação de triglicerídeos em seu exame de sangue?", comment: "")
        steps += [questionStep2]
        
        let numAnswerFormat = ORKTextAnswerFormat(maximumLength: 10)
        numAnswerFormat.multipleLines = false
        let numQuestionStepTitle = "Quanto foi o aumento?"
        let numQuestionStep = ORKQuestionStep(identifier: "Aumento Triglicerideos", title: numQuestionStepTitle, answer: numAnswerFormat)
        steps += [numQuestionStep]
        
        
        let questionStep4 = ORKQuestionStep(identifier: "Q4 Mensal", title: NSLocalizedString("Doença", comment: ""), answer: ORKBooleanAnswerFormat())
        questionStep4.text = NSLocalizedString("Você teve alguma alteração hepática?", comment: "")
        steps += [questionStep4]
        
        let exameAnswerFormat = ORKTextAnswerFormat(maximumLength: 30)
        exameAnswerFormat.multipleLines = false
        let exameQuestionStepTitle = "Qual foi o exame alterado?"
        let exameQuestionStep = ORKQuestionStep(identifier: "Exame Alterado", title: exameQuestionStepTitle, answer: exameAnswerFormat)
        steps += [exameQuestionStep]
        
        let numAnswerFormat2 = ORKTextAnswerFormat(maximumLength: 10)
        numAnswerFormat2.multipleLines = false
        let numQuestionStepTitle2 = "Quanto foi o aumento?"
        let numQuestionStep2 = ORKQuestionStep(identifier: "Aumento Hepático", title: numQuestionStepTitle2, answer: numAnswerFormat2)
        steps += [numQuestionStep2]
        
        let feelingStep = ORKQuestionStep(identifier: "Uso Novos Remedios", title: "Novos Remédios", answer: ORKTextAnswerFormat(maximumLength: 255))
        feelingStep.title = "Novos Remédios"
        feelingStep.text = "Se você começou a tomar algum medicamento novo durante este mês, descreva qual foi, quantas vezes você toma por dia e qual a quantidade (dose)?"
        steps += [feelingStep]
        
        //Add summary step
        let summaryStep = ORKInstructionStep(identifier: "Sumario Mensal")
        summaryStep.title = NSLocalizedString("Agradecimentos", comment: "")
        summaryStep.text = NSLocalizedString("Seus dados foram coletados. Obrigado por participar da nossa pesquisa!", comment: "")
        steps += [summaryStep]
        
        return ORKOrderedTask(identifier: "MonthlySurveyTask", steps: steps)
    }
    
    
    public var diaryTask : ORKOrderedTask {
        var steps = [ORKStep]()
        
        let introStep = ORKInstructionStep(identifier: "Intro Diario")
        introStep.title = NSLocalizedString("Diário", comment: "")
        introStep.text = NSLocalizedString("Aqui você poderá escrever seus sentimentos e pensamentos.", comment: "")
        steps += [introStep]
        
        let feelingStep = ORKQuestionStep(identifier: "Sentimentos", title: "Diário", answer: ORKTextAnswerFormat())
        feelingStep.title = "Diário"
        feelingStep.text = "Escreva seus sentimentos aqui."
        steps += [feelingStep]
        
        return ORKOrderedTask(identifier: "Diary", steps: steps)
    }
}